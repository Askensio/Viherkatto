function Search() {
    function getObject() {
		// The data id of the search form tells the class of the searched object
        return $('#search-form').attr('data-id');
    }
    this.object = getObject();
}

// Function that builds up the get query of the search
Search.prototype.buildQueryParameters = function () {

    var parameters = ""

    var elements = $('.search-input');
	// Iterates trough all the input class elements
    $.each(elements, function (i, element) {
		// Checks if the input of the search was a textinput or a selectbox
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


