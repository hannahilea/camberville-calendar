using Pkg
Pkg.activate("scripts/scrape/city-of-somerville")
using HTTP
using Logging
using HttpCommon
using EzXML
using DataFrames

const URL = "https://www.somervillema.gov/"

function get_calendar_items(url=URL; verbose=true)
    all_events = []
    i_max_pages = 100 # For this particular url, we are unlikely to hit this amount....
    i_page = 0
    while true
        r = HTTP.get(URL * "calendar?page=$(i_page)")
        html = with_logger(NullLogger()) do
            return root(parsehtml(String(r.body)))
        end

        html_events = findall("//div[@class='views-row']", html)
        events = filter(!ismissing, map(parse_event, html_events))
        verbose && (@info "Calendar page $(i_page): $(length(events)) events found")
        if !isempty(events)
            append!(all_events, events)
        end

        # Bail early if we have enough events!
        if length(events) == 0
            if i_page == 1
                throw(ErrorException("No events found on any page; check that page structure hasn't changed!"))
            end
            break
        end

        i_page += 1
        if i_page >= i_max_pages
            @warn "Only collected 100 pages of events, still more pages are available..."
            break
        end
    end
    return DataFrame(all_events)
end

function parse_event(html_event)
    # Get title and link from same element
    a = findall(".//span[@class='views-field views-field-title']//a", html_event)
    if length(a) != 1
        @warn "Uh oh, more than 1 element link found..."
        return missing
    end
    title = nodecontent(only(a))
    url = URL * only(a)["href"]

    # Get times from other element
    times = findall(".//time", html_event)
    length(times) == 0 && return missing
    length(times) > 2 && (@warn "Why are there more than 2 times???")
    start_time = first(times)["datetime"]
    end_time = length(times) == 1 ? missing : times[2]["datetime"]
    return (; title, start_time, end_time, url)
end

all_items = get_calendar_items(; verbose=true)

""" 

A truly opinionated filtering! Remove anything not "camberville fun", including recurring events
"""
function camberville_calendar_opinionated_filter(events)

    # Generic filters
    retained_titles = filter(events.title) do t
        title = rstrip(lstrip(lowercase(t)))

        # Is there an event that would otherwise be filtered out by the below filters, 
        # but should definitely be kept? force keep it here by uncommenting the 
        # following row:
        # isequal(title, "your event name lowercase") && return true

        # exclude named holidays---events ON those holidays are demarcated differently
        occursin("holiday:", title) && return false

        # exclude civil proceedings
        occursin("webinar", title) && return false
        occursin("comittee", title) && return false
        occursin("commission", title) && return false
        startswith(title, "slice of the city") && return false # specific per-ward event series
        occursin("meeting", title) && return false
        occursin("hearing", title) && return false
        occursin("workshop", title) && return false
        occursin("reconstruction outreach", title) && return false
        occursin("candidate interviews", title) && return false
        occursin("early voting", title) && return false
        occursin("election", title) && return false

        # ...and events
        occursin("rodent", title) && return false # LOL
        occursin("hazardous waste", title) && return false
        isequal("narcan distribution", title) && return false
        startswith(title, "last day to") && return false

        # exclude recurring classes, open houses, and gallery hours
        # ...council on aging events seem to always(?) be group classes on exercise, etc; 
        occursin("council on aging", title) && return false
        occursin(" course ", title) && return false
        startswith(title, "general exercise") && return false
        isequal(title, "culturehouse union square") && return false
        occursin("open gallery", title) && return false

        # exclude events whose main purpose is fundraising
        occursin("fundraiser", title) && return false

        # Keep for now, maybe exclude in future if calendar becomes bloated 
        isequal(title, "union square farmers market") && return false

        # Specifically exclude; fail inclusion criteria but not captured by other generic filters (for now)
        isequal(title, "the soul rebels") && return false  #ticketed concert
        isequal(title, "2024 red sox disability pride celebration") && return false #ticketed game
        startswith(title, "\"kaleidoscope: ") && return false # partnering externally
        isequal(title, "haitian flag raising 2024") && return false # civil/flag-raising (no obvious associated festival?)
        isequal(title, "city wide swim meet") && return false # todo

        return true
    end

    return filter(:title => in(retained_titles), events)

end

wanted_events = camberville_calendar_opinionated_filter(all_items)

//
using DelimitedFiles
writedlm("test-1.csv", eachrow(wanted_events), ',')

using JSONTables
open("test-1.json", "w") do f
    df = rename(wanted_events, "title" => "event", "start_time" => "startDate", "end_time" => "endDate", "url" => "details")
    insertcols!(df, 1, :location => "Somerville")
    transform!(df, :details => ByRow(d -> string("<a href=\"", d, "\">Source</a>")),
        #    :startDate => ByRow(d -> "<time>$d</time>"),
        #    :endDate => ByRow(d -> "<time>$d</time>"),
        ; renamecols=false)

    write(f, arraytable(df))
end



#= 
Opinionated filter---general flowchart. if the answer to any is yes, it probably won't 
be included in the Camberville Calendar 
- is it closed to the public? 
- does it require advance registration for a limited number of open spots?
- does it charge admission for a limited number of open spots?
- is it an announcement of a longer-term opening rather than an event/party? (e.g., notice of gallery exhibit opening without corresponding gala, an open house, etc)
- is it a civil/political procedure rather than a festive event? (e.g., a committee meeting, hearing, open interviews, flag raising, etc)
- is it an acknowledgement of an existing date rather than an event with a time(s) and/or place(s)? (e.g., notice of public holiday)
- is it explicitly a fundraiser above else?
- is it a somewhat niche external event series that the city is partnering on?

The following events are currently in a middle category---I'm excluding them for now, but may exclude them in the future:
- farmer's market (pro: it is festive/open to the public; con: weekly recurrance)


Commentary: 
- search is TERRIBLE. searching by name must be full name of event (how would yo uknow it??) and seems to include the current date selection (which is by default the current day, unless you go and manually remove it fro mthe url---which, how would people know to do that?)
=#
