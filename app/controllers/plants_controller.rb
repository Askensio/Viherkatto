# encoding: UTF-8

class PlantsController < ApplicationController

  before_filter :admin_user, only: [:new, :create, :update, :destroy, :edit]

  #respond_to :html, :xml, :json

  def show
    @plant = Plant.find(params[:id])
  end

  def index
    #@plants = Plant.paginate(page: params[:page])
    respond_to do |format|
      @plants = Plant.paginate(page: params[:page])
      format.html { render :html => @plants } # index.html.erb

      if params[:page].present?
        @jsonPlants = Plant.paginate(page: params[:page], per_page: params[:per_page])
      else
        @jsonPlants = Plant.all
      end

      @jsonPlantsDub = [:Plant]

      if params[:name].present?
        #@jsonPlantsDub = [:Plant]

        @jsonPlants.each do |p|
          if !p.name.downcase.include?(params[:name].downcase)
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:latin_name].present?
        @jsonPlants.each do |p|
          if !p.latin_name.downcase.include?(params[:latin_name].downcase)
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:colour].present?
        @jsonPlants.each do |p|
          if !p.colour.downcase.include?(params[:colour].downcase)
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:maintenance].present?
        @jsonPlants.each do |p|
          if p.maintenance.to_i != params[:maintenance].to_i
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:coverage].present?
        @jsonPlants.each do |p|
          if p.coverage.to_i != params[:coverage].to_i
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:min_soil_thickness].present?
        @jsonPlants.each do |p|
          if p.min_soil_thickness.to_i < params[:min_soil_thickness].to_i
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:weight_is].present?
        @jsonPlants.each do |p|
          if p.weight.to_i != params[:weight_is].to_i
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:weight_atleast].present?
        @jsonPlants.each do |p|
          if p.weight.to_i < params[:weight_atleast].to_i
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      if params[:weight_max].present?
        @jsonPlants.each do |p|
          if p.weight.to_i > params[:weight_max].to_i
            @jsonPlantsDub << p
          end
        end
        #@jsonPlants -= @jsonPlantsDub
      end

      @jsonPlants -= @jsonPlantsDub

      format.json { render :json => {count: @plants.total_entries, plants: @jsonPlants} }

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
