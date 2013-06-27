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

    groof_hash = Hash.new { |hash, key| hash[key] = Hash.new }


    groofs.each do |groof|
      environment_hit_count = 0
      groof.roof.environments do |env|
        params[:environments].each do |e|
          if env.id == e.id
            environment_hit_count += 1
          end
        end
      end
      groof_hash[groof]['environment_count'] = environment_hit_count
    end

    groofs.each do |groof|
      plant_count = 0
      groof.plants.each do |plant|
        if plant_index_array.include? plant.id
          plant_count += 1
        end
      end
      groof_hash[groof]['plant_count'] = plant_count
    end

    groof_hash = groof_hash.sort_by { |x| [ x.last['plant_count'], x.last['environment_count']] }.reverse

    temp_bases = Array.new
    groof_hash.each do |key, value|
      temp_bases.push key
    end

    groofs = temp_bases[0,3]

    return groofs
  end

  private

  def sort_by_plants groofs, plant_index_array

    #puts "------------------"
    #puts groofs

    groof_hash = Hash.new



    groof_hash = groof_hash.sort_by { |_key, value| value }.reverse


    temp_array = Array.new
    groof_hash.each do |key, value|
      temp_array.push key
    end

    groofs = temp_array

    return groofs
  end
end
