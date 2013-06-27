module GreenroofsHelper

  def printPlants (greenroof)
    plants = []
    output = '';
    output.html_safe
    greenroof.plants.each { |plant| plants.push((link_to plant.name, plant_path(plant)).html_safe) }
    hash = Hash[plants.map.with_index.to_a]

    plants.each_with_index { |plant|
      if hash[plant] < plants.size - 1
        output << plant
        output << ', '

      else
        output << plant

      end
    }
    output.html_safe
  end

  def printCustomPlants (greenroof)
    output = '';
    if greenroof.custom_plants.count != 0
      output << ', '
    end
    customPlants = []

    greenroof.custom_plants.each { |plant| customPlants.push((plant.name)) }
    hash = Hash[customPlants.map.with_index.to_a]

    customPlants.each_with_index { |plant|
      if hash[plant] < customPlants.size - 1
        output << plant
        output << ', '

      else
        output << plant

      end
    }
    output.html_safe
  end

  def printAddress(greenroof)
  if (greenroof.address.blank?)
    return ""
  else
    return greenroof.address + ", "
  end
  end



  def printBases (greenroof)
    bases = []
    output = '';
    output.html_safe
    index = 1;
    greenroof.bases.each_with_index { |base| bases.push(printLayers(base))
    index.next
    }
    hash = Hash[bases.map.with_index.to_a]


    bases.each_with_index { |base|
      if hash[base] < bases.size - 1
        output << base
        output << ', '

      else
        output << base

      end
    }
    output.html_safe
  end


  private

  def printLayers(base)
    layerpile = []
    output = '';
    output.html_safe
    base.layers.each { |layer| layerpile.push((link_to layer.name, layer_path(layer)).html_safe) }
    hash = Hash[layerpile.map.with_index.to_a]

    layerpile.each_with_index { |layer|
      if hash[layer] < layerpile.size - 1
        output << layer
        output << ', '

      else
        output << layer

      end
    }
    output.html_safe
  end
 end
