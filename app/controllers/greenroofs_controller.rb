# encoding: UTF-8

class GreenroofsController < ApplicationController

  before_filter :signed_user, only: [:new, :create]

  def new
    @greenroof = Greenroof.new
    @base = Base.new
    @layer = Layer.new

    @base.layers << @layer

    @roof = Roof.new
    @greenroof.bases << @base
    @greenroof.roof = @roof
    @environments = Environment.all

=begin
    @layer2 = Layer.new
    @base.layers << @layer2
    @base2 = Base.new
    @layer3 = Layer.new
    @base2.layers << @layer3
    @greenroof.bases << @base2
=end

  end

  def create

    @greenroof = Greenroof.new(params[:greenroof])
    @greenroof.user = current_user

    @roof = Roof.new(params[:roof])

    if not params[:environment].nil?
      params[:environment][:id].shift
      params[:environment][:id].each do |env|
        @env = Environment.find_by_id(env)
        if (@env != nil)
          @roof.environments << @env
        end
      end
    else
      flash.now[:error] = "Et valinnut ympäristöä."
      respond_to do |format|
        #format.js { render :action => 'new' }
      end
      return
    end

    @greenroof.roof = @roof

    @bases = params[:bases]
    @bases.each do |key, value|
      @base = Base.new(value[:base])
      value[:layers].each do |key, value|
        @layer = Layer.new(value)
        @base.layers << @layer
      end
      @greenroof.bases << @base
    end


    if params[:plants].nil?
      #flash.now[:error] = "Et lisännyt yhtään kasvia."
      respond_to do |format|
        #format.js { render :action => 'new' }
      end
      return
    else
      params[:plants].each do |id|
        @plant = Plant.find_by_id(id)
        if not @plant.nil?
          @greenroof.plants << @plant
        end
      end
    end

    if @greenroof.save!
      flash[:success] = "Viherkaton lisäys onnistui!"
      render :js => "window.location = '/'"

    else
      if not params[:plants].nil? and not params[:environment][:id].empty?
        respond_to do |format|
          #format.js { render :action => 'new' }
        end
      end
    end
  end
end
