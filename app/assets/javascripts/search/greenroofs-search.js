$(document).ready(function () {

    var searcher = new Search();
    var paginator = new Pagination("search/greenroofs",1,20)

    var clickListener = function () {

        var params = searcher.buildQueryParameters()
        console.log(params)
        paginator.parameters = params
        paginator.getObjects(true)
    }

    $('[name="hae"]').click(clickListener);
});

// The function that the paginator needs, detemines what kind of elemets are put in the pagination.
var addElement = function (entry, admin) {
    var listElement = $('<li></li>');
    console.log(entry.address)
    console.log(entry.locality)
    var location;
    if (entry.address.length == 0) {
        location = entry.locality
    } else {
        location = entry.address
    }
    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + 'Omistajan ' + entry.owner + ' viherkatto paikassa ' + location + '</a>');
    listElement.append(link);
    if (admin) {
        listElement.append(' | ');
        var deleteElement = $('<a href=\"#\" id="/' + this.object + 's/' + entry.id + '\">' + 'poista' + '</a>').click(this.deleteRequest);
        listElement.append(deleteElement).append(' | ');
        var editElement = $('<a href=\"/' + this.object + 's/' + entry.id + '/edit\">' + 'muokkaa' + '</a>');
        listElement.append(editElement);
    }
    $('.' + this.object + '-list').append(listElement);
}
