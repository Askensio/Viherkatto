/**
 * Created with JetBrains RubyMine.
 * User: vito
 * Date: 6.6.2013
 * Time: 12:27
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function () {
    var searcher = new Search();
    $('[name="hae"]').click(searcher.buildQueryParameters)
});

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

        parameters += $(this).attr('data-id') + '=' + $(this).val() + '&'

//        if (i != 0) {
//            parameters += $(this).attr('data-id') + '=' + $(this).val() + '&'
//        } else {
//            parameters += $(this).attr('data-id') + '=' + $(this).val()
//        }
    });
    console.log(parameters)
}
