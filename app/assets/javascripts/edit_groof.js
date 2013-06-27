$(document).ready(function () {
    initalize()

    function initalize() {

        $('.remove-layer-button').each(function(index, element) {
            $(this).click(removeParent)
        })
        {
            $('.construction_year').append(" " + ($("#greenroof_year").val()));
            $('.construction_year').show()
            $('.locality').append(" " +($("#greenroof_locality").val()));
            $('.address').append(" " + ($("#greenroof_address").val()));
            $('.address').show()
            $('.constructor').append(" " + ($("#greenroof_constructor").val()));
            $('.constructor').show()
            $('.owner').append(" " + ($("#greenroof_owner").val()));
            $('.owner').show()
            $('.note').append(" " + ($("#greenroof_note").val()));
            $('.area').append(" " + ($("#roof_area").val()+' m²'));
            $('.role').empty()
            $('.role').append("Lisätty roolissa: " + ($("#role_id").find(":selected").text()));
            $('.role').show()
            $('.declination').empty();
            $('.declination').append("Kaltevuus: " + determineDeclination());
            $('.location').append(" " + ($("#environment_id option:selected").text()));
            $('.capacity').append(" " + ($("#roof_load_capacity").val() + "kg/m²"));
            $('.purpose').empty()
            $('.purpose').append("Käyttötarkoitus: " + ($("#purpose_id").find(":selected").text() + " "));


            var id = $('#form').attr('data-for')

            var addedPlants = []

            $.getJSON("/greenroofs/" + id + "/edit.json", function(data) {
                console.log(JSON.stringify(data))
                console.log(JSON.stringify(data["plants"]))
                $.each(data["plants"], function(index, plant_object) {

                    console.log((index))
                    console.log((plant_object["name"]))
                    var id = plant_object["id"]
                    plantHandler.push(id)


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
                        plantHandler.remove(id)
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

            $('.absorbancy').append($("#base_absorbancy").val());
            $('#save').unbind('click')
            $('#save').click(save_edits)
        }
}
});

function save_edits() {
    var data = save()
    if (data != null) {
    sendEditData(data)
    }
}

function sendEditData(data) {

    var id = $('#form').attr('data-for')

    $.ajax({

        url: "/greenroofs/" + id,
        type: 'PUT',
        data: data,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function (response) {
            console.log('Greenroof id: ' + response.id + ' saved')

            var imageData = new FormData()

            jQuery.each($('#image-upload')[0].files, function(i, file) {
                imageData.append('file-'+i, file);
            });


        }
    });
}

function sendEditImage(imageData, id) {
    $.ajax({
        url: '/greenroofs/' +id + '/upload',
        type: 'PUT',
        data: imageData,
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function (response) {
            console.log(response)
        }
    });
}






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


