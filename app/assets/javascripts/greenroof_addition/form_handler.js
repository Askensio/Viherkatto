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

    layerDropdownList.each(function(index, value) {
        $(this).parent().click(addLayer)
        //console.log($(this).parent())
    })
    //$('#add-base-button').click(addBase)
    $('#save').click(save)
    $('#add-layer-button').click(function(e) {
        e.preventDefault()
    })

}

var customPlant = function(event) {
    event.preventDefault();
    var input = $('#custom-plant-name').val()
    if (input != "") {
        customPlants.push(input)
    }
    $('#custom-plant-name').val("");
    var listElement = $('<li></li>')
    listElement.append(input)
    listElement.append(iconMinus());
    listElement.click(function(e) {
        customPlants.splice(customPlants.indexOf(input), 1)
        $(this).remove();
    });
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
    console.log(addLayerButton)
    var linkList = addLayerButton.children('ul')
    linkList.each(function(index, value) {
        $(this).parent().click(addLayer)
        console.log($(this).parent())
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
    //console.log(spandexElement.text())
    var parentDiv = $(this).parents('div:eq(0)')
    var layerElement = generateLayerForm(textElementForLayer    .text())
    parentDiv.before(layerElement)
}

function generateLayerForm(layerName) {
    // creates a new container for the layer form
    var layerFormElement = $('<div></div>').attr('class', 'layer' )

    if(layerName === 'Muu') {
        var nameLabel = $('<label for="layer_name">Kerroksen nimi *</label>')
        var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" required="required" size="30" type="text">')
        layerFormElement.append(nameLabel)
        layerFormElement.append(nameInput)
    } else {
        var name= $('<h4>' + layerName + '</h4>')
        var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" size="30" type="hidden" value="'+ layerName +'">')
        layerFormElement.append(name)
        layerFormElement.append(nameInput)

    }
    var productLabel =  $('<label for="layer_product_name">Tuotteen nimi</label>')
    var productInput = $('<input class="span4" id="layer_product_name" name="layer[product_name]" size="30" type="text">')
    var thicknessLabel = $('<label for="layer_thickness">Paksuus (cm) *</label>')
    var thicknessInput = $('<input class="span4" id="layer_thickness" name="layer[thickness]" required="required" size="30" type="text">')
    var weightLabel = $('<label for="layer_weight">Paino (kg/m2) *</label>')
    var weightInput = $('<input class="span4" id="layer_weight" name="layer[weight]" required="required" size="30" type="text">')

    if(layerName == 'Suodatinkangas' || layerName == 'Asennussuoja') {
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

var save = function (event) {
    var roof = createRoofObject()
    var environments = createEnvironmentsObject()
    var bases = createBasesArray()
    var greenroof = createGreenroofObjcet()
    var customplant = createCustomplantsObject()

    var data = new Object()

    data.roof = roof
    data.environment = environments
    data.bases = bases
    data.customPlants = customplant
    if (plants.length < 1) {
        alert("Et valinnut yhtään kasvia")
    }
    data.plants = plants
    data.greenroof = greenroof

    sendData(data)
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

    //console.log(JSON.stringify(roof))
    return roof
}

function createEnvironmentsObject() {

    var environments = new Object()
    var id = []

    $("#environment_id option:selected").each(function (index) {
        id.push($(this).attr('value'))
        console.log($(this).attr('value'))
    });
    if (id.length < 1) {
        alert("Valitse sijainti")
    }
    environments.id = id

    //console.log(JSON.stringify(environments))
    return environments
}

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
    //console.log(JSON.stringify(bases))
    return bases
}

function createLayerObjectArray(baseElement) {

    var layerArray = []
    var layers = baseElement.children('div')
    layers.each(function (index) {
        console.log($(this).children($('h4')))
        var layer = new Object()
        var name = $(this).children('[name="layer[name]"]').val()
        layer.name = name
        var product_name = $(this).children('[name="layer[product_name]"]').val()
        layer.product_name = product_name
        var thickness = $(this).children('[name="layer[thickness]"]').val()
        layer.thickness = thickness
        var weight = $(this).children('[name="layer[weight]"]').val()
        layer.weight = weight
        layerArray.push(layer)
    });
    //console.log(JSON.stringify(layerArray))
    return layerArray
}

function createGreenroofObjcet() {

    var greenroof = new Object()
    greenroof.address = $('#greenroof_address').val()
    greenroof.constructor = $('#greenroof_constructor').val()
    greenroof.note = $('#greenroof_note').val()
    greenroof.purpose = 1
    greenroof.year = $('#greenroof_year').val()
    return greenroof
}

function sendData(data) {

    $.ajax({
        url: '/greenroofs',
        type: 'POST',
        data: data,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function (response) {
        }
    });
}

function setPlants(plantIDs) {
    plants = plantIDs
}