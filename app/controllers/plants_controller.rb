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

      if params[:name].present?
        #@jsonPlants = nil
        #@jsonPlants = Plant.first
        @jsonPlantsDub = [:Plant]

        @jsonPlants.each do |p|
          if !p.name.downcase.include?(params[:name].downcase)
            @jsonPlantsDub << p
          end
        end
        @jsonPlants -= @jsonPlantsDub
      end

      if params[:maintenance].present?
        @jsonPlantsDub = nil
        @jsonPlantsDub = [:Plant]

        @jsonPlants.each do |p|
          if p.maintenance.to_i != params[:maintenance].to_i
            @jsonPlantsDub << p
          end
        end
        @jsonPlants -= @jsonPlantsDub
      end


      #if params[:maintenance].present?
      #  @jsonPlantsDub = nil
      #  @jsonPlantsDub = [:Plant]
      ##
      #  @jsonPlants.each do |p|
      #
      #    if p.maintenance == params[:maintenance]
      #      @jsonPlantsDub << p
      #    end
      #  end
      #  @jsonPlants = @jsonPlantsDub
      #end

      #if params[:coverage].present?
      #  @jsonPlantsDub = nil
      #  @jsonPlantsDub = [:Plant]
      #
      #  @jsonPlants.each do |p|
      #    if p.coverage == params[:coverage]
      #      @jsonPlantsDub << p
      #    end
      #  end
      #  @jsonPlants = @jsonPlantsDub
      #end


      #:coverage, :latin_name, :aestethic_appeal, :colour, :light_requirement, :maintenance, :min_soil_thickness, :name, :note, :weight

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
