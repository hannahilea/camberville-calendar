
var options = {
    valueNames: ['event', 'startDate', 'endDate', 'location', 'details']
};

let values;
let hackerList;
fetch('./test-1.json')
    .then((response) => response.json())
    .then((json) => {
        console.log(json);
        values = json;
        hackerList = new List('event-list', options, values);
    });


