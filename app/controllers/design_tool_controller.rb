# encoding: UTF-8

class DesignToolController < ApplicationController
  def design
    @plant = Plant.new
    @roof = Roof.new
  end

  def create_design

    @bases = Array.new

    # Fills the array with bases that are attached to the selected plants, if no plants are selected all bases are selected.
    unless params[:plants].nil?
      @plants = Plant.where(:id => params[:plants]).uniq.all
      @plants.each do |plant|
        @bases += plant.bases
      end
    else
      @bases = Base.where("greenroof_id IS ?", nil).uniq.all
    end

    # In this part all the bases that does not match the load-capacity criteria are filtered out.
    base_indexes = Array.new
    @bases.each do |base|
      weight = 0
      weight += base.absorbancy unless base.absorbancy.nil?
      base.layers.each do |layer|
        weight += layer.weight
      end
      unless weight > params[:roof][:load_capacity].to_i
        base_indexes.push base.id
      end
    end
	# Makes a query for all the bases that were not filetered out.
    @bases = Base.where(:id => base_indexes)

    
    base_hash = Hash.new { |hash, key| hash[key] = Hash.new }

    @bases.each do |base|
	  # Sets in the hash the count of plants attached to the base
      base_hash[base]['length'] = base.plants.length
      unless params[:plants].nil?
        count = 0
        base.plants.each do |plant|
          if params[:plants].include? plant.id.to_s
            count += 1
          end
        end
      end
	  # Sets in the hash the count of plants that were attached into the base and that were selected in the desing tool
      base_hash[base]['plant_hits'] = count
    end
	# Sorts the bases in a manner that the bases that has most plants attached to them are placed in the beginning
    base_hash = base_hash.sort_by { |x| [ x.last['plant_hits'], x.last['length']] } .reverse

    temp_bases = Array.new
	# Goes trough the has and saves the keys (the base objects) in an temp array.
    base_hash.each do |key, value|
      temp_bases.push key
    end
    @bases = temp_bases
	# Picks the 5 most matched bases
    @bases = @bases[0, 5]

    render 'show'
  end
end
