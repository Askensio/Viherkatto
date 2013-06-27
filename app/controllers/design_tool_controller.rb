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

    @bases = Base.where(:id => base_indexes)



    # Sorts the bases in a manner that the bases that has most plants attached to them are placed in the beginning

    base_hash = Hash.new

    @bases.each do |base|
      base_hash[base] = base.plants.length
    end

    puts "-------------------------------"
    puts "Hash before sort"

    puts base_hash

    base_hash.values.sort!
    puts "Hash after sort"

    puts base_hash
    puts "-------------------------------"

    render 'show'

=begin
    respond_to do |format|
      @response = 'jee'
      #format.json { render :json => {response: @response} }
    end
=end
  end
end
