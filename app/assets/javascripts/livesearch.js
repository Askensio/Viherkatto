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

        $.getJSON("/plants.json", function (data) {

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

    $("#roof_area").keyup(function() {
        var input = $("#roof_area").val();
        console.log("foo");
        $('.area').empty();
        $('.area').append('Pinta-ala: '+input+' (m2)');
    })

    $("#roof_declination").keyup(function() {
        var input = $("#roof_declination").val();
        $('.declination').empty();
        $('.declination').append('Kaltevuus: ' + input);
    })

    $("#environment_id").change(function() {
        var input = $("#environment_id").val();
        console.log(input);
    })

    $("#roof_load_capacity").keyup(function() {
        var input = $("#roof_load_capacity").val();
        $('.capacity').empty();
        $('.capacity').append('Kantavuus: ' + input + ' (kg/m2)');
    })


    $("#search").keyup(function() {
        var searchword = $("#search").val();
            $.getJSON("/plants.json?name=" + searchword, function (data) {
                plantdata = []
                plantdata = data["plants"];

//                if (plantdata.length === 0) {
//                    var listElement = $('<li></li>');
//                    var addPlantButton = $('<div class=\"btn-large\"><p>Lisää oma kasvi</p></div>');
//                    listElement.append(addPlantButton);
//                    $('.plant-list').append(listElement);
//                    console.log("enpty!");
//                }

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

        addedPlants.push(id)
        setPlants(addedPlants)

        chosenOne.click(
            function(e) {
               // e.target.remove()
            }
        );
        var listElement = $('<li></li>');
        listElement.append(chosenOne.clone().attr('id', 'selected_plant_id_' + chosenOne.attr('id')));
        $('.chosen-list').append(listElement).append('<br>');
        console.log(parent)
        //parent.remove()
    }

});
