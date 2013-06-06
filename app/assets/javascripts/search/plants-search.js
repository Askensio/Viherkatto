$(document).ready(function () {

    var searcher = new Search();
    var paginator = new Pagination("search/plants")

    var clickListener = function () {
        var params = searcher.buildQueryParameters()
        console.log("NAPPI PAINETTU")
        paginator.parameters = params
        paginator.getObjects()
    }

    $('[name="hae"]').click(clickListener);
});