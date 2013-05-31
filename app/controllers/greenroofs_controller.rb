# encoding: UTF-8

class GreenroofsController < ApplicationController
  def new
    @greenroof = Greenroof.new
    @base = Base.new
    @roof = Roof.new
    @environments = Environment.all
    @layer = Layer.new
    @base = Base.new
  end

  def create

    @greenroof = Greenroof.new( params[:@greenroof] )

    params[:bases].each do |base|
      @base = Base.new( base )

      base[:layers].each do |layer|
        @layer = Layer.new(layer)
        @base << @layer
      end
      @greenroof << @base
    end

    @roof = Roof.new( params[:roof] )
    params[:environment][:id].shift
    if (!params[:environment][:id].empty?)
      params[:environment][:id].each do |env|
        @env = Environment.find_by_id(env)
        if (@env != nil)
          @roof.environments << @env
        end
      end
    end

    @greenroof.roof = @roof

    params[:plants].each do |id|
      @plant = Plant.find_by_id(id)
      if not @plant.nil?
        @greenroof.plants << @plant
      end
    end

    if @greenroof.save
      flash.now[:success] = "Viherkaton lisäys onnistui!"
      redirect_to root_url
    else
      render 'new'
    end
  end
end
