# encoding: UTF-8

class BasesController < ApplicationController

  before_filter :admin_user

  def new
    @base = Base.new
  end

  def create
    @base = Base.new(params[:base])

    if  params[:layers]
      params[:layers].each do |key, layer|
        @base.layers << Layer.new(layer)
      end
    end

    if @base.save!
      flash[:success] = "Lisäys onnistui!"
      render :js => "window.location = '/bases'"
    else
      render 'new'
    end
  end

  def index
    respond_to do |format|
      #@bases = Base.paginate(page: params[:page])
      format.html { render :html => @bases } # index.html.erb

      bases = Base.where("greenroof_id IS ?", nil)

      if params[:page].present?
        @jsonBases = bases.paginate(page: params[:page], per_page: params[:per_page])
      else
        @jsonBases = Base.all
      end

      format.json { render :json => {admin: admin?, count: @jsonBases.total_entries, bases: @jsonBases} }
    end
  end

  def show
    @base = Base.find(params[:id])
    unless @base.greenroof_id.nil?
      return
    end
    respond_to do |format|
      format.html
      format.json { render :json => {attached_plants: @base.plants} }
    end
  end

  def attach
    @plant = Plant.find(params[:plant_id])
    @base = Base.find(params[:id])

    unless @base.greenroof_id.nil?
      return
    end

    @base.plants << @plant unless @base.plants.where(:id => @plant.id).present?
    respond_to do |format|
      format.json { render :json => {success: true} }
    end
  end

  def detach

    base = Base.find(params[:id])
    plant = base.plants.find(params[:plant_id])
    respond_to do |format|
      if plant
        if base.plants.delete(plant)
          format.json { render :json => {success: true} }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if Base.find(params[:id]).destroy
        @response = "success"
      else
        @response = "error"
      end
      format.json { render :json => {response: @response} }
    end
  end
end
