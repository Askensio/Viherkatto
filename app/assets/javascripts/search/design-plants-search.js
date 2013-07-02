$(document).ready(function () {

    var searcher = new Search();
    var paginator = new Pagination("search/plants", 1, 10)

    var clickListener = function () {

        var params = searcher.buildQueryParameters()
        console.log(params)
        paginator.parameters = params
        paginator.getObjects(true)
    }

    $('[name="hae"]').click(clickListener);

    $('#generate-button').click(generate)

    $(document).keyup(function (e) {
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 13) { //Enter keycode
            generate()
        }
    })
});

// Generates the data to be sent for the design-tool backend.
function generate() {
    // Removes all error messages
    $('.alert-error').each(function () {
        $(this).remove()
    })

    var data = new Object()
    data.roof = generateRoofData()

    if (!data.roof) {
        return
    }

    data.environments = generateEnvironmentsData()
    data.plants = PlantSelectionHandler.getPlants()

    console.log("send data " + JSON.stringify(data))

    sendDesignData(data)
}

// Generates the data about the roof
function generateRoofData() {

    var alertElement = $('<div class="alert alert-error"></div>')

    var roof = new Object()

    var valid = true

    roof.load_capacity = $('#roof_load_capacity').val()
    if (roof.load_capacity === "" || isNaN(roof.load_capacity)) {
        alertElement.html('Anna katon kantavuus.')
        $('#roof_load_capacity').after(alertElement.clone())
        valid = false
    }

    if (valid) {
        return roof
    } else {
        return valid
    }
}

// Generates the data from the environment checkobox.
function generateEnvironmentsData() {

    var environments = []

    $("#environment_id option:selected").each(function () {
        environments.push(parseInt($(this).val()))
    })

    return environments
}

// As the name tells, sends the data for the design tool as an ajax call.
function sendDesignData(data) {

    $.ajax({
        url: '/suunnittele',
        type: 'POST',
        data: data,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function (response) {
            document.open()
            document.write(response)
            document.close()
        }
    });
}

// The handler that controls what plants are selected in the design-tool.
var PlantSelectionHandler = new function () {

    var plants = []

    this.select = function (id) {
        plants.push(id)
    }

    this.unselect = function (id) {
        plants.splice(plants.indexOf(id), 1)
    }

    this.contains = function (id) {
        if (plants.indexOf(id) > -1) {
            return true
        } else {
            return false
        }
    }

    this.getPlants = function () {
        return plants
    }

    this.print = function () {
        console.log(plants)
    }
}

// Listener for the button to add a plant in the selecet list.
function addButtonListener(event) {

    var parent = $(event.target).parent().clone()
    var removeButton = parent.children('button')
    removeButton.unbind('click')
    removeButton.click(removeButtonListener)
    removeButton.attr('class', 'btn btn-danger btn-mini link-base-to-plant-button')
    removeButton.html('Poista')
    $('#selected-plants').append(parent)
    var id = parseInt($(event.target).attr('id'))
    PlantSelectionHandler.select(id)

    $(event.target).attr('disabled', 'true')
}
// Listener for removing a selected plant from the selected list.
function removeButtonListener(event) {
    $(event.target).parent().remove()
    var id = parseInt($(event.target).attr('id'))
    PlantSelectionHandler.unselect(id)
    $('.plant-list #' + id).removeAttr('disabled')
}

// The add element function for the plant search pagination
var addElement = function (entry, admin) {
    var listElement = $('<li></li>');
    var addButton = $('<button class="btn btn-mini link-base-to-plant-button" id="' + entry.id + '">Lisää</button>')
    addButton.click(addButtonListener)

    if (PlantSelectionHandler.contains(parseInt(entry.id))) {
        addButton.attr('disabled', 'true')
    }
    listElement.append(addButton)

    var link = $('<a href=\"/' + this.object + 's/' + entry.id + '\">' + entry.name + '</a>');
    listElement.append(link);
    $('.' + this.object + '-list').append(listElement);
}