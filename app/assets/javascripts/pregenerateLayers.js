function pregenerateLayers(layer) {
    var layerFormElement = $('<div></div>').attr('class', 'layer' )

    if(layer.name === 'Muu') {
        var nameLabel = $('<label for="layer_name">Kerroksen nimi *</label>')
        var nameInput = $('<input class="span4" id="layer_name" name="layer[name]" required="required" size="30" type="text">')
        nameInput.attr('value', layer.name)
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

    if(layer.name == 'Suodatinkangas' || layer.name == 'Asennussuoja') {
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
