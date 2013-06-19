$(document).ready(function () {
    initalize()

    function initalize() {

        $('.remove-layer-button').each(function(index, element) {
            $(this).click(removeParent)
        })
        {
            $('.construction_year').append($("#greenroof_year").val());
            $('.locality').append($("#greenroof_locality").val());
            $('.address').append($("#greenroof_address").val());
            $('.constructor').append($("#greenroof_constructor").val());
            $('.note').append($("#greenroof_note").val());
            $('.area').append($("#roof_area").val()+' m²');
            $('.declination').empty();
            $('.declination').append("Kaltevuus: " + determineDeclination());
            $('.location').append($("#environment_id option:selected").text());
            $('.capacity').append($("#roof_load_capacity").val() + "kg/m²");
            var id = $('#form').attr('data-for')
            var addedPlants = []
            $.getJSON("/greenroofs/" + id + "/edit.json", function(data) {
                console.log(JSON.stringify(data))
                console.log(JSON.stringify(data["plants"]))
                $.each(data["plants"], function(index, plant_object) {

                    console.log((index))
                    console.log((plant_object["name"]))
                    var id = plant_object["id"]

                    addedPlants.push(id)
                    setPlants(addedPlants)

                    var listElement = $('<li></li>');
                    var plant = $('<a href="/plants/' + id + '">' + (plant_object["name"]) + '</a>');

                    plant.click(
                        function(e) {
                            // e.target.remove()
                        }
                    );
                    listElement.append(plant.attr('id', 'selected_plant_id_' + plant.attr("id")));
                    var icon = iconMinus()

                    icon.click(function(e)
                    {

                        addedPlants.splice(addedPlants.indexOf(id), 1)
                        $(this).parent().remove();
                        console.log(addedPlants.length)
                    });
                    listElement.append(icon);
                    listElement.append('<br>');
                    $('.chosen-list').append(listElement);
                    //console.log(parent)
                    //console.log(addedPlants)
                    //parent.remove()


                })
            })



        }
   }
});

function determineDeclination() {
    var input = $("#roof_declination").val();
    if (input === '0') {
        return "Tasakatto"
    } else if (input === '1') {
        return "Loiva"
    } else {
        return "Jyrkkä"
    }

}


