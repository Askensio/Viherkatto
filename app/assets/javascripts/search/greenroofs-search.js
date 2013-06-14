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

var addElement = function (entry, admin) {
    var listElement = $('<li></li>');
    console.log(entry)
    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + 'Käyttäjän ' + entry.user + ' viherkatto paikassa ' + entry.locality + '</a>');
    listElement.append(link);
//    console.log(admin)
    if (admin) {
        listElement.append(' | ');
        var deleteElement = $('<a href=\"#\" id="/' + this.object + 's/' + entry.id + '\">' + 'poista' + '</a>').click(this.deleteRequest);
        listElement.append(deleteElement).append(' | ');
        var editElement = $('<a href=\"/' + this.object + 's/' + entry.id + '/edit\">' + 'muokkaa' + '</a>');
        listElement.append(editElement);
    }
    $('.' + this.object + '-list').append(listElement);
}
