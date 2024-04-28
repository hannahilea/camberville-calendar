# Camberville Calendar

[![stability-wip](https://img.shields.io/badge/stability-wip-lightgrey.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#work-in-progress)

One-stop dashboard for city-wide happenings: view site [here](hannahilea.github.io/camberville-calendar/).

## Goal
- Bird's-eye-view of fun public events, to enable:
    - generic planning around local events: "i want to be around for honk fest/open studios/etc"
    - day-of planning: "i want to do something fun, are there any public events happening?"
        - don't get too granular: this particular need is already served by e.g. The Boston Calendar, bostonshows.org
        - don't do anything that could easily be answered by visiting one single other site BUT can link to those sites

## Plan
- Basic website. Nothing flashy. Very vanilla.
- Embedded google calendar with link to subscribe to said calendar. 
    - Maybe also RSS feed?
- For now, might be easiest to add stuff manually (gross)
    - Local calendars are terribly maintained---scraping isn't necessarily a useful approach 
    - Allegedly somerville city newsletters are "better", but they aren't public? I only just registered, so let's see what comes in and if that is scrapable 
- Future: automated updating
    - maybe! depends on how mnay things actually belong on the calendar, and how often they change. might still be less overall work to update manually (with some tooling to support event creation)

## What shows up on calendar?
- Include events for: 
    - somerstreets, 
    - SAC,
    - fluff fest, 
    - open studios, 
    - events for neighborhood orgs (e.g. union square, [east somerville](https://www.eastsomervillemainstreets.org), etc)
    - equivalent cambridge events

Don't include: 
    - city meetings 
    - recurring private events, incl classes 
    - one-off private events unless they're billed as public festivals 
    - anything that would be better served by e.g. 

TBD: 
    - farmer's markets 
    - museum events (mit museum, harvard museums, etc)
    - library events
    - university events (tufts, harvard, etc)
    - kid events e.g. city sports
    - flea 

- Link to (regardless of inclusion in calendar):
    - Music listings: Boston shows https://bostonshows.org/  + their links to other concert listings
    - Boston calendar
    - Cambrdige Day https://www.cambridgeday.com/category/arts-and-culture/events-ahead/ 
    - City event/meeting calendars
    - Places that offer classes 
    - list of links from https://www.reddit.com/r/CambridgeMA/comments/169d02t/best_way_to_find_cambridgesomerville_events/ (some might be relevant to include directly)
    - https://www.get2thegigbos.com/ 
    - boston hassel
    - eventbrite, meetup for local area searches (esp if they have page widgets)
    - MAMAS etc
    - https://calendar.artsboston.org/categories/free-events/ 

## Questions
- Why are all these "official" calendars so inconsistently maintained?!
    - do people just not know what's happening in their community, or is there some other way they're being reached?
        - maybe the email newsletters?
            - why aren't the previous email newsletters available to read retroactively?! 
        - ...some other mailing list? belonging to the groups directly?
        - facebook?? instagram? 
- How has it taken me *this* long to realize how hard this info is to access, even if you go looking for it??
- How have those weird pop-up street e-ink displays gotten their info? was it comprehensive at all? (i suspect not...)

## Next steps
- [ ] Set up basic site 
- [ ] Set up basic calendar
    - [ ] Make calendar public 
    - [ ] Add it to site
- [ ] Add "under development" badge 
- [ ] Get domain
- [ ] Set up pattern for adding new event
    - [ ] update list on site
    - [ ] add event to calendar
- [ ] Add RSS feed for new events
- [ ] How to handle updating event (day/time/cancellation/etc) (incl rss feed)
- [ ] How to handle removing stale events from homepage
- [ ] if event listings haven't become obvious from newsletters, consider reaching out to each group...

### To use, probably 
- https://listjs.com/
