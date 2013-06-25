$(document).ready(function () {

    var searcher = new Search();
    var paginator = new Pagination("search/plants",1,10)

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

    var addButton = $('<button class="btn btn-mini link-base-to-plant-button" id="' + entry.id + '">Lisää</button>')
    listElement.append(addButton)

    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.name + '</a>');
    listElement.append(link);
    $('.' + this.object + '-list').append(listElement);
}