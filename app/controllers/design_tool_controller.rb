# encoding: UTF-8

class DesignToolController < ApplicationController
  def design
    @plant = Plant.new
    @roof = Roof.new
  end

  def create_design

    @bases = Array.new


    unless params[:plants].nil?
      @plants = Plant.where(:id => params[:plants]).uniq.all
      @plants.each do |plant|
        @bases += plant.bases
      end
    else
      @bases = Base.where("greenroof_id IS ?", nil).uniq.all
    end

    puts "-------------------------------"

    puts "Roof load capacity is " + params[:roof][:load_capacity].to_s

    base_indexes = Array.new

    @bases.each do |base|

      weight = 0
      weight += base.absorbancy unless base.absorbancy.nil?

      base.layers.each do |layer|
        weight += layer.weight
      end

      puts "Base total weight is : " + weight.to_s

      unless weight > params[:roof][:load_capacity].to_i
        puts "Total weight was more than roof capacity"
        base_indexes.push base.id
      end
    end

    @bases = Base.where(:id => base_indexes)
    #puts "Bases count : " + @bases.count.to_s

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
