$(document).ready(function () {

    getAttachedPlants()
    //$('.pagination').click(getAttachedPlants)
});

var attached_plant_ids = []

// Gets the plants attached to the current base and places the ids of those plants into the "attached_plant_ids" var.
function getAttachedPlants() {

    var id = $('#base-table').attr('data-id')
    // Gets the plants by JSON
    $.getJSON('/bases/' + id + '.json', handleResponse);

    // And fetches the ids of the plants attached to the base. Afterwards paginates all the plants in the view.
    function handleResponse(data) {
        $.each(data.attached_plants, function (key, val) {
            attached_plant_ids.push(val.id);
        });

        var paginator = new Pagination("plants", 1, 15)
        paginator.getObjects(true)
    }

}

var addElement = function (entry, admin) {

    var linkageButton

    if ($.inArray(entry.id, attached_plant_ids) < 0) {
        linkageButton = $('<button class="btn btn-mini link-base-to-plant-button" id="' + entry.id + '">Lisää</button>').click(addButtonClickListener)
    } else {
        linkageButton = $('<button class="btn btn-mini btn-danger link-base-to-plant-button" id="' + entry.id + '">Poista</button>').click(removeButtonClickListener)
    }
    var listElement = $('<li></li>');

    listElement.append(linkageButton)
    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.name + '</a>');
    listElement.append(link);
    $('.' + this.object + '-list').append(listElement);

    function removeButtonClickListener(event) {
        var data = new Object()
        data.plant_id = $(event.target).attr('id')
        data.base_id = $('#base-table').attr('data-id')

        $.ajax({
            url: '/bases/' + data.base_id + '/detach',
            type: 'POST',
            data: data,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (response) {
                responseHandler(response)
            }
        });

        function responseHandler(response) {
            if (response["success"]) {
                $(event.target).unbind('click')
                $(event.target).attr('class', 'btn btn-mini link-base-to-plant-button').text("Lisää")
                $(event.target).click(addButtonClickListener)
            }
        }
    }

    function addButtonClickListener(event) {
        var data = new Object()
        data.plant_id = $(event.target).attr('id')
        data.base_id = $('#base-table').attr('data-id')

        $.ajax({
            url: '/bases/' + data.base_id + '/attach',
            type: 'POST',
            data: data,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (response) {
                responseHandler(response)
            }
        });

        function responseHandler(response) {
            if (response["success"]) {
                $(event.target).unbind('click')
                $(event.target).attr('class', 'btn btn-danger btn-mini link-base-to-plant-button').text("Poista")
                $(event.target).click(removeButtonClickListener)
            }
        }
    }
}