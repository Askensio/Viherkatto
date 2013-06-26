module DesignToolHelper

  def get_matching_greenroofs base
    greenroof_indexes = Array.new
    base.plants.each do |plant|
      temp_array = Array.new
      plant.greenroofs.each do |groof|
        temp_array.push groof.id
      end
      greenroof_indexes = greenroof_indexes | temp_array
    end
    greenroof_indexes = greenroof_indexes[0,10]

    groofs = Greenroof.where(id: greenroof_indexes).all
    return groofs
  end
end
