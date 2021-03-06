$(document).ready(function () {
    init()
});

var plants = []
var customPlants = []

// initializes the button listeners for the form
function init() {
    $('#add-custom-plant').click(customPlant)

    $('#form').submit(function (event) {
        // cancels the form submission
        event.preventDefault();
    });
    var layerDropdownList = $("a[class='layer-option']")
    //console.log($("a[class='layer-option']"))

    layerDropdownList.each(function (index, value) {
        $(this).parent().click(addLayer)
        //console.log($(this).parent())
    })
    //$('#add-base-button').click(addBase)
    $('#save').click(create_groof)
    function create_groof(event) {
        var data = save()
        if (validateData(data)){
            sendData(data)
        }

    }

    $('#add-layer-button').click(function (e) {
        e.preventDefault()
    })

}

var customPlant = function (event) {
    event.preventDefault();
    var input = $('#custom-plant-name').val()
    if (input != "") {
        customPlants.push(input)
    }
    $('#custom-plant-name').val("");
    var listElement = $('<li></li>')
    var removeButton = $('<i class=\"btn btn-mini clickable add-plant-for-greenroof\">Poista</i>').click(function (e) {
        customPlants.splice(customPlants.indexOf(input), 1)
        $(this).parent().remove()
        $(this).remove();
    });
    listElement.append(removeButton);
    listElement.append(" ");
    listElement.append(input)
    $('#theplants').append(listElement)
}

// listener function for the addition of a new base
var addBase = function addBase(event) {

    event.preventDefault()
    var formElement = $('#base-form')
    formElement.append(generateBaseForm())
}
function generateBaseForm() {

    // gets the number of direct div child elements of #base-form
    var baseCount = $('#base-form > div').size() + 1
    // adds the container for the form
    var baseFormElement = $('<div></div>').attr('id', 'base' + baseCount).attr('class', 'baseAdder')
    // adds the header
    var h2Element = $('<h2>Kerros ' + baseCount + '</h2>').attr('class', 'span4')
    baseFormElement.append(h2Element)
    // adds a button for removing the base
    var removeButton = $('<button>Poista kerros</button>').attr('class', "btn btn-mini btn-danger").click(removeParent)
    baseFormElement.append(removeButton)
    var labelElement = $('#base-form div label').first().clone()
    baseFormElement.append(labelElement)
    var absorbancyInputElement = $('#base-form div input').first().clone().val("");
    baseFormElement.append(absorbancyInputElement)

    var addLayerButton = $('#add-layer-btn-grp').clone()
    var linkList = addLayerButton.children('ul')
    linkList.each(function (index, value) {
        $(this).parent().click(addLayer)
    })
    baseFormElement.append(addLayerButton)
    return baseFormElement
}

// function for removing the invoked element's parent (in this case the remove buttons parents)
var removeParent = function (event) {
    $(event.target).parent().remove()
}

// listener for the addition of a new layer form
var addLayer = function addLayer(event) {

    console.log($(event.target).parents('li:eq(0)').text())

    event.preventDefault()

    var textElementForLayer = $(event.target).parents('li:eq(0)')
    var parentDiv = $(this).parents('div:eq(0)')
    var layerElement = generateLayerForm(textElementForLayer.text())
    parentDiv.before(layerElement)
}

function generateLayerForm(layerName) {
    // creates a new container for the layer form
    var layerFormElement = $('<div></div>').attr('class', 'layer')

    if (layerName === 'Muu') {
        var nameLabel = $('<label for="layer_name">Kerroksen nimi *</label>')
        var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" required="required" size="30" type="text">')
        layerFormElement.append(nameLabel)
        layerFormElement.append(nameInput)
    } else {
        var name = $('<h4>' + layerName + '</h4>')
        var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" size="30" type="hidden" value="' + layerName + '">')
        layerFormElement.append(name)
        layerFormElement.append(nameInput)

    }
    var productLabel = $('<label for="layer_product_name">Tuotteen nimi</label>')
    var productInput = $('<input class="span4" id="layer_product_name" name="layer[product_name]" size="30" type="text">')
    var thicknessLabel = $('<label for="layer_thickness">Paksuus (cm) *</label>')
    var thicknessInput = $('<input class="span4" id="layer_thickness" name="layer[thickness]" required="required" size="30" type="text">')
    var weightLabel = $('<label for="layer_weight">Paino (kg/m2) *</label>')
    var weightInput = $('<input class="span4" id="layer_weight" name="layer[weight]" required="required" size="30" type="text">')

    if (layerName == 'Suodatinkangas' || layerName == 'Asennussuoja') {
        thicknessInput.attr('value', '0').attr('disabled', 'true')
        weightInput.attr('value', '0').attr('disabled', 'true')

    }

    layerFormElement.append(productLabel)
    layerFormElement.append(productInput)
    layerFormElement.append(thicknessLabel)
    layerFormElement.append(thicknessInput)
    layerFormElement.append(weightLabel)
    layerFormElement.append(weightInput)

    var removeButton = $('<br><button>Poista kerros</button>').attr('class', "btn btn-mini btn-danger remove-layer-button").click(removeParent)
    layerFormElement.append(removeButton)

    return layerFormElement
}
// A function that gathers all the data in the form and places them in one object.
var save = function () {

    var roof = createRoofObject()
    var environments = createEnvironmentsObject()
    var bases = createBasesArray()
    var greenroof = createGreenroofObject()
    var customplant = createCustomplantsObject()
    var purposes = createPurposeObject()
    var role = createRoleObject()

    var data = new Object()

    data.purpose = purposes
    data.roof = roof
    data.environment = environments
    data.bases = bases
    data.customPlants = customplant

    data.role = role
    if (plantHandler.getArray().length < 1) {
        alert("Et valinnut yhtään kasvia")
    }

    data.plants = plantHandler.getArray()
    data.greenroof = greenroof
    data.role = role

    return data
}


function createRoleObject() {
    var role = new Object()

    var selected = $('#role_id').find(":selected");

    if (selected === null) {
        alert("Valitse rooli")
    }
    role.value = selected.text()
    return role
}


function createCustomplantsObject() {
    var customPlantArray = new Object()
    customPlantArray.plants = customPlants
    return customPlantArray
}

function createRoofObject() {

    var area = $('#roof_area').val()
    var declination = $('#roof_declination').val()
    var load_capacity = $('#roof_load_capacity').val()
    var locations = []
    var roof = new Object()
    roof.area = area
    roof.declination = declination
    roof.load_capacity = load_capacity

    return roof
}

function createPurposeObject() {
    var purposes = new Object()
    var id = []

    $("#purpose_id option:selected").each(function (index) {
        id.push($(this).attr('value'))
    });
    purposes.id = id
    return purposes
}

function createEnvironmentsObject() {

    var environments = new Object()
    var id = []

    $("#environment_id option:selected").each(function (index) {
        id.push($(this).attr('value'))
    });
    environments.id = id
	
    return environments
}

// Saves the data of the base, because initially there was a possibility to create multiple
// bases the function would support of gathering data from multiple bases.
function createBasesArray() {

    var bases = []

    $('#base-form > div').each(function (index) {

        var baseAndLayers = new Object()
        $(this).children('[name="base[absorbancy]"]')
        var absorbancy = $(this).children('[name="base[absorbancy]"]').val()
        var base = new Object()
        base.absorbancy = absorbancy
        baseAndLayers.base = base

        var layers = createLayerObjectArray($(this))
        baseAndLayers.layers = layers
        bases.push(baseAndLayers)
    });
    console.log(JSON.stringify(bases))
    return bases
}
// Creates an array from all the layers associated into a base.
function createLayerObjectArray(baseElement) {

    var layerArray = []
    var layers = baseElement.children('div')
    layers.each(function (index) {
        var layer = new Object()
        var name = $(this).children('[name="layer[name]"]').val()
        if (typeof name === 'undefined') {
            return
        }
        layer.name = name
        var product_name = $(this).children('[name="layer[product_name]"]').val()
        layer.product_name = product_name
        var thickness = $(this).children('[name="layer[thickness]"]').val()
        if (isNaN(thickness)) {
            thickness = 0;
        }
        layer.thickness = thickness
        var weight = $(this).children('[name="layer[weight]"]').val()
        if (isNaN(weight)) {
            weight = 0;
        }
        layer.weight = weight
        layerArray.push(layer)
    });
    console.log(JSON.stringify(layerArray))
    return layerArray
}

function createGreenroofObject() {

    var greenroof = new Object()
    greenroof.address = $('#greenroof_address').val()
    greenroof.locality = $('#greenroof_locality').val()
    greenroof.constructor = $('#greenroof_constructor').val()
    greenroof.note = $('#greenroof_note').val()
    greenroof.year = $('#greenroof_year').val()
    greenroof.owner = $('#greenroof_owner').val()
    greenroof.usage_experience = $('#greenroof_usage_experience').val()
    return greenroof
}

var createdAlerts = []

/*
 Validates the data processed by the save-variable. Alerts will be created and shown to the user if data is not correct.
 Data that is not correct will not be sent.
 */
function validateData(data) {


    for (var i = 0; i < createdAlerts.length; i++) {
        createdAlerts[i].remove()
    }


    var problems = 0
    var ladiesOfSuspiciousBackground = 0
    if (ladiesOfSuspiciousBackground === 1 && problems === 99) {
        console.log('CHECK YOUR STANDARDS FRIEND')
    }

    // Greenroof validations

    if (data.greenroof.year < 1900 || data.greenroof.year > 2100) {
        createValidationAlert('Valmistumisvuoden tulee olla välillä 1900 - 2100').insertAfter('#greenroof_year')
        problems++
    }
    if (data.greenroof.locality.length < 1) {
        createValidationAlert('Valitse viherkatollesi paikkakunta').insertAfter('#greenroof_locality')
        problems++
    }
    if (data.greenroof.owner.length < 1) {
        createValidationAlert('Anna viherkatollesi omistaja').insertAfter('#greenroof_owner')
        problems++
    }
    if (data.purpose.id.length < 1) {
        createValidationAlert('Et valinnut viherkattosi käyttötarkoitusta').insertAfter('#purpose-choose')
        problems++
    }
    if (data.role.value === "Valitse rooli") {
        createValidationAlert('Et valinnut roolia.').insertAfter('#role-choose')
        problems++
    }

    // Roof validations
    if (data.roof.area < 1) {
        createValidationAlert('Aseta viherkattosi pinta-alaksi vähintään yksi').insertAfter('#roof_area')
        problems++
    }

    if (data.roof.load_capacity < 1) {
        createValidationAlert('Aseta kattosi kantavuudeksi vähintään yksi').insertAfter('#roof_load_capacity')
        problems++
    }

    if (data.roof.declination === "") {
        createValidationAlert('Aseta katollesi kaltevuus').insertAfter('#roof_declination')
        problems++
    }

    if (data.environment.id < 1) {
        createValidationAlert('Valitse vielä viherkattosi sijainti').insertAfter('.envs.btn-group')
        problems++
    }

    // Plant validations
    if (data.plants.length < 1) {
        createValidationAlert('Valitse ainakin yksi katollasi sijaitseva kasvi').insertAfter('.foundation-plants')
    }


    if (problems > 0) {
        alert('Syöttämäsi viherkaton tiedoissa oli virheitä tai puutteita.')
        return false
    }
    return true
}


function createValidationAlert(validationText) {
    var createdAlert = $('<div class="alert"><button type="button" class="close" data-dismiss="alert">&times;</button><strong>Virhe! </strong>' + validationText + '</div>')
    createdAlerts.push(createdAlert)
    return createdAlert

}

// Sends the data to the servers. The success function receives as a response the id of the newly created
// greenroof and the success function passes the id and the possibly attached file to the function that
// sends the image data.
function sendData(data) {

    $.ajax({
        url: '/greenroofs',
        type: 'POST',
        data: data,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function (response) {
            console.log('Greenroof id: ' + response.id + ' saved')

            var imageData = new FormData()

            jQuery.each($('#image-upload')[0].files, function (i, file) {
                imageData.append('file-' + i, file);
            });
			
            sendImage(imageData, response.id)
        }
    });
}
// Sends the image data to the server.
function sendImage(imageData, id) {
    $.ajax({
        url: '/greenroofs/' + id + '/upload',
        type: 'POST',
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

var plantHandler = new function () {

    var ids = []

    this.push = function (id) {
        ids.push(id)
    }
    this.remove = function (id) {
        ids.splice(ids.indexOf(id), 1)
    }

    this.makeUnique = function () {
        ids = jQuery.unique(ids)
    }

    this.getArray = function () {
        return ids;
    }
}

function setCustomPlants(plantIDs) {
    customPlants = plantIDs
}
