# encoding: UTF-8

class PlantsController < ApplicationController

  before_filter :admin_user, only: [:index,:new,:create,:update,:destroy]

  def show
    @plant = Plant.find(params[:id])
  end

  def index
    #@plants = Plant.all
    @plants = Plant.paginate(page: params[:page])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(params[:plant])
    if @plant.save
      flash[:success] = "Kasvin lisäys onnistui!"
      redirect_to plants_url
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
