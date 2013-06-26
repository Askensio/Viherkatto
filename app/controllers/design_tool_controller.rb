# encoding: UTF-8

class DesignToolController < ApplicationController
  def design
    @plant = Plant.new
    @roof = Roof.new
  end

  def create_design

    @bases = Array.new

    puts "-------------------------------"

    unless params[:plants].nil?
      @plants = Plant.where(:id => params[:plants]).uniq.all
      @plants.each do |plant|
        @bases += plant.bases
      end
      #Post.includes(:groups => :users).where('users.id' => current_user.id)
      #@bases = Base.includes(:base_plants => :plants)
    else
      @bases = Base.where("greenroof_id IS ?", nil).uniq.all
    end

    puts "Bases count : " + @bases.count.to_s
    #puts "Plant count : " + @plants.count.to_s

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
