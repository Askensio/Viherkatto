$(document).ready(function () {

    (function () {
        getPlants();
    })();


    function paginate(entry_count, per_page) {
        var total = Math.ceil(entry_count / per_page);
        $('.pagination').bootpag({
            total: total,
            page: 1,
            maxVisible: 10
        }).on('page', function (event, num) {
                getPlants(num, per_page)
            });
    }

    function getPlants(page, per_page) {
        var firstLoad = false;
        if (page === undefined && per_page === undefined) firstLoad = true;
        if (page === undefined) page = 1;
        if (per_page === undefined)  per_page = 20;

        $.getJSON("/plants.json?page=" + page + "&per_page=" + per_page, function (data) {

            var entry_count = data["count"];
            var plants = data["plants"];

            // If it is the first time that the view is loaded then the pagination will be rendered also.
            if (firstLoad) {
                paginate(entry_count, per_page)
                firstLoad = false;
            }

            // Clears the plant list.
            $('.plant-list').empty();

            // And lists the queried plants.
            $.each(plants, function (i, item) {
                addPlantElement(item);
            });
        });
    }

    // Function that creates a single list element in the plant list
    function addPlantElement(entry) {

        $('.plant-list').append('<li><a href=\"/plants/' + entry.id + '\">' + entry.name + '</a></li>');
    }
});