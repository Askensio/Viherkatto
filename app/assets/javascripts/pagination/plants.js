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

    function addPlantElement(entry) {

        var listElement = $('<li></li>');
        var plantLink = $('<a href=\"/plants/' + entry.id + '\">' + entry.name + '</a>');
        listElement.append(plantLink);
        listElement.append(' | ');
        var deleteElement = $('<a href=\"#\" id=\"/plants/' + entry.id + '\">' + 'poista' + '</a>').click(
            function (e) {
                console.log(e.target.getAttribute('id'))
                var url = e.target.getAttribute('id')
                $.ajax({
                    url: url,
                    type: 'DELETE',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                    },
                    success: function (result) {
                        getPlants()
                    }
                });

            });
        listElement.append(deleteElement).append(' | ');
        var editElement = $('<a href=\"/plants/' + entry.id + '/edit\">' + 'muokkaa' + '</a>');
        listElement.append(editElement);
        $('.plant-list').append(listElement);
    }
});