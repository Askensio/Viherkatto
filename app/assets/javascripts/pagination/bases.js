$(document).ready(function () {
    var paginator = new Pagination("bases", 1, 20)

    paginator.getObjects(true)
});


var addElement = function (entry, admin) {
    var listElement = $('<li></li>');
    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.name + '</a>');
    listElement.append(link);
    listElement.append(' | ');
    var deleteElement = $('<a href=\"#\" id="/' + this.object + 's/' + entry.id + '\">' + 'poista' + '</a>').click(this.deleteRequest(this));
    listElement.append(deleteElement)

    $('.' + this.object + '-list').append(listElement);
}