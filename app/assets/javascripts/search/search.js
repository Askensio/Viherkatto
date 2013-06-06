function Search() {
    function getObject() {
        return $('#search-form').attr('data-id');
    }
    this.object = getObject();
}

Search.prototype.buildQueryParameters = function () {

    var parameters = ""

    var elements = $('.search-input');
    $.each(elements, function (i, element) {
        if ($(this).is('input') && $(this).val() != '') {
            parameters += $(this).attr('data-id') + '=' + escape($(this).val()) + '&'
        } else if ($(this).is('select')) {
            var type = $(this).attr('data-id');
            var options = $(this).children();

            $.each(options, function (i, element) {
                if ($(element).attr('selected') === 'selected') {
                    parameters += type + '[]=' + escape($(this).text()) + '&';
                }
            });
        }
    });
    return parameters
}


var addElement = function (entry, admin) {
    var listElement = $('<li></li>');
    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.name + '</a>');
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