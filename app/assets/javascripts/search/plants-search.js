$(document).ready(function () {

    var searcher = new Search();
    var paginator = new Pagination("search/plants",1,20)

    var clickListener = function () {

        var params = searcher.buildQueryParameters()
        console.log(params)
        paginator.parameters = params
        paginator.getObjects(true)
    }

    $('[name="hae"]').click(clickListener);
});