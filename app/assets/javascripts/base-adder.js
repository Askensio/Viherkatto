$(document).ready(function () {
    attachClickListeners()
})

function attachClickListeners() {
    // Attaches the click listeners into the dropdown menu
    var layerDropdown = $('.bootstrap-select')
    var linkList = layerDropdown.children('ul')
    linkList.children('li').each(function (index, value) {
        $(this).click(addLayer)

    })

    $('#save-button').click(save)

    function save() {

        var layer_array = []
        // Iterates trough the layer divs
        $('.layer').each(function(index, element) {

            var layer = new Object()
            layer.name = $(this).children('#layer_name').val()
            layer.product_name = $(this).children('#layer_product_name').val()
            layer.thickness = $(this).children('#layer_thickness').val()
            layer.weight = $(this).children('#layer_weight').val()
            layer_array.push(layer)
        })

        var base = new Object()
        base.absorbancy = $('#base_absorbancy').val()
        base.note = $('#base_note').val()
        base.layers = layer_array

        // Sends the base data
        $.ajax({
            url: '/bases',
            type: 'POST',
            data: base,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (response) {
                console.log(response)
            }
        });
    }

    // Function that adds a new layer in the view
    function addLayer(event) {

        var layerName = $(event.target).parents('li:eq(0)').text()

        var layerElement = $('<div></div>').attr('class', 'layer' )

        if(layerName === 'Muu') {
            var nameLabel = $('<label for="layer_name">Kerroksen nimi *</label>')
            var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" required="required" size="30" type="text">')
            layerElement.append(nameLabel)
            layerElement.append(nameInput)
        } else {
            var name= $('<h4>' + layerName + '</h4>')
            var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" size="30" type="hidden" value="'+ layerName +'">')
            layerElement.append(name)
            layerElement.append(nameInput)

        }
        var productLabel =  $('<label for="layer_product_name">Tuotteen nimi</label>')
        var productInput = $('<input class="span4" id="layer_product_name" name="layer[product_name]" size="30" type="text">')
        var thicknessLabel = $('<label for="layer_thickness">Paksuus (cm) *</label>')
        var thicknessInput = $('<input class="span4" id="layer_thickness" name="layer[thickness]" required="required" size="30" type="text">')
        var weightLabel = $('<label for="layer_weight">Paino (kg/m2) *</label>')
        var weightInput = $('<input class="span4" id="layer_weight" name="layer[weight]" required="required" size="30" type="text">')

        if(layerName == 'Suodatinkangas' || layerName == 'Asennussuoja') {
            thicknessLabel = $('<div></div>')
            thicknessInput.attr('value', '0').attr('type', 'hidden')
            weightLabel = $('<div></div>')
            weightInput.attr('value', '0').attr('type', 'hidden')

        }

        layerElement.append(productLabel)
        layerElement.append(productInput)
        layerElement.append(thicknessLabel)
        layerElement.append(thicknessInput)
        layerElement.append(weightLabel)
        layerElement.append(weightInput)

        var removeButton = $('<br><button>Poista kerros</button>').attr('class', "btn btn-mini btn-danger remove-layer-button").click(function(e) {
            $(e.target).parents('div:eq(0)').remove()
        })
        layerElement.append(removeButton)

        $('.bootstrap-select').before(layerElement)
    }
}