# encoding: UTF-8

require 'will_paginate/array'

class PlantsController < ApplicationController

  before_filter :admin_user, only: [:new, :create, :update, :destroy, :edit]

  # Controller function for plant show, returns plant of given parameters

  def show
    @plant = Plant.find(params[:id])
  end

  # Controller function for index page. Renders into json, also enables possibility
  # to find plants by their names

  def index
    respond_to do |format|

      @plants = Plant.order('lower(name) ASC').paginate(page: params[:page])
      format.html { render :html => @plants } # index.html.erb
      if params[:page].present?
        @jsonPlants = Plant.order('lower(name) ASC').paginate(page: params[:page], per_page: params[:per_page])
      else
        @jsonPlants = Plant.all
      end

      @jsonPlantsDub = [:Plant]

      if params[:name].present?
        @jsonPlants.each do |p|
          if !p.name.downcase.include?(params[:name].downcase)
            @jsonPlantsDub << p
          end
        end
      end

      @jsonPlants -= @jsonPlantsDub
      format.json { render :json => {admin: admin?, count: @plants.total_entries, plants: @jsonPlants} }
    end
  end

  # Controller function for new plant page

  def new
    @plant = Plant.new
    3.times do
      @plant.links.build
    end
  end

  # Controller function for editing plant page

  def edit
    @plant = Plant.find(params[:id])
    if @plant.links.empty?
      3.times do
        @plant.links.build
      end
    end
  end

  # Controller function for creating of plant. Creates a new plant from given
  # parameters and then uses processAssociatedParams function to update attributes
  # and to keep function shorter. On succesful save redirects to plants index,
  # otherwise renders new

  def create
    @plant = Plant.new(params[:plant])

    processAssociatedParams

    if @plant.save
      if @plant.light_id.nil?
        @plant.update_attribute(:light_id, Light.first.id)
      end
      flash[:success] = "Kasvin lisäys onnistui!"
      redirect_to plants_url
    else
      render 'new'
    end
  end

  # Controller function for updating a plant. Updates a plant with given
  # parameters and then uses processAssociatedParams function to update
  # attributes and to keep function shorter. On succesful save redicts to plants
  # show page, otherwise renders edit

  def update
    @plant = Plant.find(params[:id])

    processAssociatedParams

    if @plant.update_attributes(params[:plant]) && @plant.update_attribute(:light_id, params[:light][:id])
      redirect_to plant_url
    else
      render 'edit'
    end
  end

  # Destroy function to delete plants. Takes plant id as parameters and
  # then tries to find it and calls its destroy function. Then returns appropriate
  # response string

  def destroy
    respond_to do |format|
      if Plant.find(params[:id]).destroy
        @response = "success"
      else
        @response = "error"
      end
      format.json { render :json => {response: @response} }
    end
    #render :nothing => true
  end

  # Enables searching for plants. Gets a list of parameters from where each
  # are checked one by one and the list of remaining plants are narrowed down.
  # Renders the remaining data into json.

  def search
    respond_to do |format|

      format.html { render :html => {plants: @plants} }

      @plants = Plant.scoped

      # Compares given attributes if params are given, otherwise narrowing of the
      # list is skipped

      @plants = @plants.where('name like ?', '%' + params[:name].downcase + '%') if params[:name]
      @plants = @plants.where('latin_name like ?', '%' + params[:latin_name].downcase + '%') if params[:latin_name]
      @plants = @plants.where('min_soil_thickness > ?', params[:min_thickness]) if params[:min_thickness]
      @plants = @plants.where('min_soil_thickness < ?', params[:max_thickness]) if params[:max_thickness]
      @plants = @plants.where('max_height <= ?', params[:max_height]) if params[:max_height]
      @plants = @plants.where('min_height >= ?', params[:min_height]) if params[:min_height]
      @plants = @plants.where('weight <= ?', params[:max_weight]) if params[:max_weight]
      @plants = @plants.where('weight >= ?', params[:min_weight]) if params[:min_weight]

      if params[:growth_environment]
        # Fixes the parameter encoding and downcases the growth environments.
        index = 0
        until index == params[:growth_environment].length
          params[:growth_environment][index] = params[:growth_environment][index].force_encoding('iso-8859-1').encode('utf-8').downcase
          index += 1
        end
        plant_indexes = Array.new

        params[:growth_environment].each do |env|
          environment = GrowthEnvironment.where('environment like ?', '%' + env + '%').first
          plant_array = Growth.select('plant_id').where('growth_environment_id = ?', environment.id).uniq
          temp_array = Array.new
          plant_array.each do |p|
            temp_array.push p.plant_id
          end
          plant_indexes = plant_indexes | temp_array
        end
        @plants = @plants.where(:id => plant_indexes)
      end

      if (params[:maintenance])
        @maints = []
        Maintenance.where(:name => params[:maintenance]).each do |id|
          @maints.push(id)
        end
        @plants = @plants.where(:maintenance_id => @maints)
      end

      if (params[:lightness])
        @lights = []
        Light.where(:value => params[:lightness]).each do |id|
          @lights.push(id)
        end
        @plants = @plants.where(:light_id => @lights)
      end

      @plants = @plants.order('lower(name) ASC')

      if params[:colour]

        # Fixes the parameter encoding and downcases the colours.
        index = 0
        until index == params[:colour].length
          params[:colour][index] = params[:colour][index].force_encoding('iso-8859-1').encode('utf-8').downcase
          index += 1
        end

        plant_indexes = Array.new

        params[:colour].each do |colour|
          col = Colour.where('value like ?', '%' + colour + '%').first
          plant_array = FlowerColour.select('plant_id').where('colour_id = ?', col.id).uniq
          temp_array = Array.new
          plant_array.each do |p|
            temp_array.push p.plant_id
          end
          plant_indexes = plant_indexes | temp_array
        end

        @plants = @plants.where(:id => plant_indexes)

      end

      @plants = @plants.paginate(page: params[:page], per_page: params[:per_page]) unless @plants.nil?
      format.json { render :json => {admin: admin?, count: @plants.total_entries, plants: @plants} }
    end
  end

  private

  # Helper methods for updating plants.
  #
  # Handles updating of attributes by checking if parameters are given
  # and then updating the attribute.

  # Calls all the processing methods and manages updating attributes

  def processAssociatedParams
    @plant.light = Light.find_by_id(params[:light][:id])
    processColours
    processGrowthEnvironments
    processLinks
    if params[:maintenances][:id]
      @plant.maintenance = Maintenance.find_by_id(params[:maintenances][:id])
    end
  end

  # Handles the updating of Growth Environments

  def processGrowthEnvironments
    params[:growth_environments][:id].shift
    if (!params[:growth_environments][:id].empty?)
      @plant.growth_environments.clear
      params[:growth_environments][:id].each do |env|
        @env = GrowthEnvironment.find_by_id(env)
        if (@env != nil)
          @plant.growth_environments << @env
        end
      end
    end
  end

  # Handles the updating of colours

  def processColours
    params[:colour][:id].shift
    if not params[:colour][:id].empty?
      @plant.colours.clear
      params[:colour][:id].each do |col|
        @col = Colour.find_by_id col
        if not @col.equal? nil
          @plant.colours << @col
        end
      end
    end
  end

  # Handles the updating of links

  def processLinks
    if params[:plant][:links_attributes]
      for i in 0..2
        @curLink = @plant.links[i]

        if !params[:plant][:links_attributes][i.to_s][:name].empty?
          @curLink.name = params[:plant][:links_attributes][i.to_s][:name]
        end
        if !params[:plant][:links_attributes][i.to_s][:link].empty?
          @curLink.link = params[:plant][:links_attributes][i.to_s][:link]
        end
      end
    end
  end
end
