$(document).ready(function () {

    (function () {
        getPlants();
    })();



    function paginate(entry_count, page, per_page) {
        var total = Math.ceil(entry_count / per_page);
        $('.pagination').empty()
        $('.pagination').bootpag({
            total: total,
            page: page,
            maxVisible: 10
        }).on('page', function (event, num) {
                getPlants(num, per_page)
            });
    }

    function getPlants(page, per_page, onDelete) {
        var reloadPaginateNeeded = false;
        if (page === undefined && per_page === undefined) reloadPaginateNeeded = true;
        if (page === undefined) page = 1;
        if (onDelete === undefined)  onDelete = false;

        if(onDelete) reloadPaginateNeeded = onDelete;

        $.getJSON("/plants.json?page=" + page, function (data) {

            var entry_count = data["count"];
            var plants = data["plants"];
            if(plants.length === 0) {
                reloadPaginateNeeded = true
                page -= 1
            }
            if (reloadPaginateNeeded) {
                paginate(entry_count, page, per_page)
                console.log("reloadin pagination")
                reloadPaginateNeeded = false;
            }
            // Clears the plant list.
            $('.plant-list').empty();
            // And lists the queried plants.
            $.each(plants, function (i, item) {
                addPlantElementForSearch(item);
            });
        });
    }


    function addPlantElementForSearch(entry) {
        var listElement = $('<li></li>');
        var plantLink = $('<a href=\"/plants/' + entry.id + '\">' + entry.name + '  </a>');
        plantLink.attr('id', entry.id)
        listElement.append(plantLink);

        listElement.append(createIconButton(-1 * entry.id));
        $('.plant-list').append(listElement);
    }



    function createIconButton(id) {
        var icon = $('<i class=\"icon-plus pull-right clickable\"></i>').attr('id', id).click( listaClikkerListener )
        return icon
    }

    var $cells = $("li");
    var plantdata = [];

    $("#search").keyup(function() {
        var searchword = $("#search").val();
            $.getJSON("/plants.json?name=" + searchword, function (data) {
                plantdata = []
                plantdata = data["plants"];
                console.log(plantdata);
                $('.plant-list').empty();
                $.each(plantdata, function (i, item) {
                    addPlantElementForSearch(item);
                    console.log(searchword);
                    console.log(item.name);
                });
            });
    });

    var addedPlants = []
    var listaClikkerListener = function(event) {
        var id = -1 * event.target.getAttribute('id')
        var chosenOne = $('#' + id)
        var parent = chosenOne.parent()

        chosenOne.click(
            function(e) {
               // e.target.remove()
            }
        );
        var listElement = $('<li class="pull-left"></li>');
        listElement.append(chosenOne.clone());
        $('.chosen-list').append(listElement).append('<br>');
        console.log(parent)
        //parent.remove()
    }

});

