# encoding: UTF-8

class DesignToolController < ApplicationController
  def design
    @plant = Plant.new
    @roof = Roof.new
  end

  def create_design

    @plants = nil
    @bases = nil
    puts "-------------------------------"

    unless params[:plants].nil?
      #@plants = Plant.where(:id => params[:plants])
      @bases = Base.joins(:plants).where(:id => params[:plants])
    else
      #@plants = Plant.scoped
      @bases = Base.joins(:plants)
    end
    #puts "Plant count : " + @plants.count.to_s

    puts "Bases count : " + @bases.count.to_s

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
