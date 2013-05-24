# encoding: UTF-8

class PlantsController < ApplicationController

  before_filter :admin_user, only: [:new,:create,:update,:destroy]

  #respond_to :html, :xml, :json

  def show
    @plant = Plant.find(params[:id])
  end

  def index
    respond_to do |format|
      @plants = Plant.paginate(page: params[:page])
      format.html { render :html => @plants}  # index.html.erb
      @jsonPlants = Plant.paginate(page: params[:page], per_page: params[:per_page])
      format.json  { render :json => {count: @plants.total_entries, plants: @jsonPlants } }
    end
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
