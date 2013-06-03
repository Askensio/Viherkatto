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

end
