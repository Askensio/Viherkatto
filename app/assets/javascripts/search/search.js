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


