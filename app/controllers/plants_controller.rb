# encoding: UTF-8

class PlantsController < ApplicationController

  before_filter :admin_user, only: [:new,:create,:update,:destroy, :edit]

  #respond_to :html, :xml, :json

  def show
    @plant = Plant.find(params[:id])
  end

  def index
    @plants = Plant.paginate(page: params[:page])
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

  def edit
    @plant = Plant.find(params[:id])
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
    @plant = Plant.find(params[:id])
    if @plant.update_attributes(params[:plant])
      # Handle a successful update.
      redirect_to plant_url
    else
      render 'edit'
    end
  end

  def destroy
    Plant.find(params[:id]).destroy
    render :nothing => true
  end
end
