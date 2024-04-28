
var options = {
    valueNames: ['event', 'startDate', 'endDate', 'location', 'details']
};

// TODO-future: pull in from json
// Values in this table were added non-comprehensively and by hand
var values = [
    { event: 'Somerville Open Studios', startDate:'2024-05-04', endDate: '2024-05-04', location: 'Somerville', details: '<a href="https://www.somervilleopenstudios.org/visit/">Details</a>'},
    { event: 'Somerville PorchFest', startDate:'2024-05-11', endDate: '2024-05-11', location: 'Somerville', details: '<a href="https://beta.somervilleartscouncil.org/porchfest/porchfest-2024/">Details</a>'}
];

var hackerList = new List('event-list', options, values);
