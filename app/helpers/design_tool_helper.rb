module DesignToolHelper

  def get_matching_greenroofs base
    greenroof_indexes = Array.new
    plant_index_array = Array.new
    base.plants.each do |plant|
      plant_index_array.push plant.id
      temp_array = Array.new
      plant.greenroofs.each do |groof|
        temp_array.push groof.id
      end
      greenroof_indexes = greenroof_indexes | temp_array
    end

    groofs = Greenroof.where(id: greenroof_indexes).all

    groof_hash = Hash.new

    groofs.each do |groof|
      plant_count = 0
      groof.plants.each do |plant|
        if plant_index_array.include? plant.id
          plant_count += 1
        end
      end
      groof_hash[groof] = plant_count
    end



    groof_hash = groof_hash.sort_by {|_key, value| value} .reverse

    puts groof_hash

    temp_array = Array.new
    groof_hash.each do |key, value|
      temp_array.push key
    end

    groofs = temp_array

    groofs = groofs[0,3]

    return groofs
  end
end
