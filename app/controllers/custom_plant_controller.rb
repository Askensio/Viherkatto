class CustomPlantController < ApplicationController

  def new
    @customPlant = CustomPlant.new
  end

  def create
    @customPlant = CustomPlant.new(params[:cplant])
  end



end
