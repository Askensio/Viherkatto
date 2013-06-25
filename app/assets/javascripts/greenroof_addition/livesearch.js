function iconMinus() {
    var icon = $('<i class=\"icon-minus\ clickable  "></i>');
    return icon;
};


$(document).ready(function () {

        /**
     * Fetches the plants through the designated function.
     */
    (function () {
        getPlants();
    })();

    /**
     * Enables pagination for the Add Plant -functionality. Pagination however disabled for now. See users.js for more information.
     * @param entry_count
     * @param page
     * @param per_page
     */
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

    /**
     * Slider click element for the Synopsis-view in the new green roof.
     */
    $("#clickDown").click(function() {
        $("#chosenOnesSlide").slideDown("slow", function() {
        });
    });

    /**
     * Slider click element for the Synopsis-view in the new green roof.
     */
    $("#clickUp").click(function() {
        $("#chosenOnesSlide").slideUp("slow", function() {
        });

    });

    /**
     * Function that fetches requested amount of plants and has built-in pagination functionality.
     * @param page
     * @param per_page
     * @param onDelete
     */
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
                //console.log("reloadin pagination")
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

    /**
     * Handles the adding of plants from the database to the search module with buttons.
     * @param entry
     */
    function addPlantElementForSearch(entry) {
        var listElement = $('<li class="plant-add-list"></li>');
        listElement.append(createIconButton(-1 * entry.id))
        var plantLink = $('<a href=\"/plants/' + entry.id + '\">' + entry.name + '  </a>');
        plantLink.attr('id', entry.id)
        listElement.append(plantLink);

        ;
        $('.plant-list').append(listElement);
    }


    /**
     * Creates the icon that is used to add a plant to the user's green roof.
     * @param id
     * @returns {*|jQuery}
     */
    function createIconButton(id) {
        var icon = $('<i class=\"btn btn-mini clickable add-plant-for-greenroof\">Lisää</i>').attr('id', id).click( listaClikkerListener )
        return icon
    }

    /**
     * Creates the icon that is used to remove the plant from the Synopsis-view and the addedPlants -array.
     * @returns {*|jQuery|HTMLElement}
     */


    var $cells = $("li");

    /**
     * Knows which plants are meant to be shown at the given moment. Used in the real-time search as the supporting data structure.
     * @type {Array}
     */
    var plantdata = [];

    /**
     * Roof area value for the Synopsis-view.
     */
    $("#roof_area").keyup(function() {
        var input = $("#roof_area").val();
        console.log("foo");
        $('.area').empty();
        $('.area').append('Pinta-ala: '+input+' (m2)');
    })

    $("#greenroof_year").keyup(function() {
        var input = $("#greenroof_year").val();
        //console.log("foo");
        $('.construction_year').empty();
        $('.construction_year').append('Valmistumisvuosi: '+input);
    })

    $("#greenroof_constructor").keyup(function() {
        var input = $("#greenroof_constructor").val();
        console.log("foo");
        $('.constructor').empty();
        $('.constructor').append('Rakennuttaja: '+input);
    })

    /**
     * Roof declination value for the Synopsis-view. Crappy if-thing because I had no idea how to make it fetch the text from the field
     * because the values are numbers.
     */
    $("#roof_declination").change(function() {
        var input = $("#roof_declination").val();
        if (input === '0') {
            input = "Tasakatto"
        } else if (input === '1') {
            input = "Loiva"
        } else if (input === '2') {
            input = "Jyrkkä"
        } else {
            input = null
        }
        $('.declination').empty();
        if (input === null) {
            $('.declination').hide();
        } else {
            $('.declination').show();
        }
        $('.declination').append('Kaltevuus: ' + input);
    })

    /**
     * Environment id value for the Synopsis-view.
     */
    $("#environment_id").change(function() {
        var input = $("#environment_id option:selected").text();
        input = input.match(/[A-Z][a-z-ä]+/g);
        if (input === null) {
            input = 'Ei sijaintia'
        }
        $('.location').empty();
        $('.location').append('Sijainti: ' + input)
    })

    $("#purpose_id").change(function() {
        var input = $("#purpose_id option:selected").text();
        input = input.match(/[A-Z][a-z-ä-ö]+/g);
        if (input === null) {
            input = 'Ei valittu'
        }
        $('.purpose').empty();
        $('.purpose').append('Käyttötarkoitus: ' + input)
    })

    /**
     * Roof load capacity value for the Synopsis-view.
     */
    $("#roof_load_capacity").keyup(function() {
        var input = $("#roof_load_capacity").val();
        $('.capacity').empty();
        $('.capacity').append('Kantavuus: ' + input + ' (kg/m2)');
    })

    /**
     * Base absorbancy value for the Synopsis-view.
     */
    $("#base_absorbancy").keyup(function(){
        var input = $("#base_absorbancy").val();
        $('.absorbancy').empty();
        $('.absorbancy').append('Vedenimukyky: ' + input + ' (l/m2)');
    })

    /**
     * Layer name value for the Synopsis-view.
     */
    $("#layer_name").keyup(function() {
        var input = $("#layer_name").val();
        $('.name').empty();
        $('.name').append('Materiaali: ' + input);
    })

    /**
     * Layer thickness value for the Synopsis-view.
     */
    $("#layer_thickness").keyup(function() {
        var input = $("#layer_thickness").val();
        $('.thickness').empty();
        $('.thickness').append('Paksuus: ' + input + ' (cm)');
    })

    /**
     * Layer weight value for the Synopsis-view.
     */
    $("#layer_weight").keyup(function() {
        var input = $("#layer_weight").val();
        $('.weight').empty();
        $('.weight').append('Paino: ' + input + ' (kg/m2)');
    })

    /**
     * Greenroof address value for the Synopsis-view.
     */
    $("#greenroof_address").keyup(function() {
        var input = $("#greenroof_address").val();
        $('.address').empty();
        if (input === "") {
            $('.address').hide();
        } else {
            $('.address').show();
        }
        $('.address').append('Osoite: ' + input);
    })

    $("#greenroof_locality").keyup(function() {
        var input = $("#greenroof_locality").val();
        $('.locality').empty();
        $('.locality').append('Paikkakunta: ' + input);
    })
    /**
     * Greenroof role value for the Synopsis-view.
     */
    $("#role_id").change(function () {
        var input = $("#role_id").find(":selected").text();
        $('.role').empty();
        if (input === null) {
          input = "Ei valittu"
        } else if (input === "Valitse rooli") {
          input = "Ei valittu"
        }
        $('.role').append('Lisätty roolissa: ' + input);
    })
    /**
     * Greenroof note value for the Synopsis-view.
     */
    $("#greenroof_note").keyup(function() {
        var input = $("#greenroof_note").val();
        $('.note').empty();
        if (input === "") {
            $('.note').hide();
        } else {
            $('.note').show();
        }
        if (input.length > 40) {
            input = input.substring(0, 40) + "..."
        }
        $('.note').append('Vapaa kuvaus: ' + input);
    })
    /**
     * Greenroof usage_experience value for the Synopsis-view.
     */
    $("#greenroof_usage_experience").keyup(function() {
        var input = $("#greenroof_usage_experience").val();
        $('.usage_experience').empty();
        if (input === "") {
            $('.usage_experience').hide();
        } else {
            $('.usage_experience').show();
        }
        if (input.length > 35) {
            input = input.substring(0, 35) + "..."
        }
        $('.usage_experience').append('Käyttökokemuksia: ' + input);
    })
    /**
     * Base absorbancy value for the Synopsis-view.
     */
    $("#base_absorbancy").keyup(function() {
        var input = $("#base_absorbancy").val();
        $('.absorbancy').empty(),
        $('.absorbancy').append('Vedenimukyky: ' + input + ' (l/m2)');
    })

    /**
     * Real-time plant search functionality is mainly provided by this.
     */
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

    /**
     * List of the plants that the user has chosen to add in his/her green roof design.
     * @type {Array}
     */
    var addedPlants = []

    /**
     * This variable is used to provide the list of all chosen plants with clickable buttons that add and remove the plants from the lists.
     * It is a rather cool way of providing a function as a parameter so you are to admire and worship it with all your heart yo.
     * @param event
     */
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
        listElement.append(iconMinus());
        listElement.append('<br>');
        listElement.click(function(e)
        {
            console.log(addedPlants.indexOf(id))
            addedPlants.splice(addedPlants.indexOf(id), 1)
            $(this).remove();
            console.log(addedPlants)
        });
        $('.chosen-list').append(listElement);
        //console.log(parent)
        //console.log(addedPlants)
        //parent.remove()
    }



});
