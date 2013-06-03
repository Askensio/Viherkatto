# encoding: UTF-8

class RoofsController < ApplicationController

  def new
    @roof = Roof.new
    @environments = Environment.all
  end

  def show
    @roof = Roof.find(params[:id])
  end

  def create
    @roof = Roof.new(params[:roof])
    params[:environment][:id].shift
    if (!params[:environment][:id].empty?)
      params[:environment][:id].each do |env|
        @env = Environment.find_by_id(env)
        if (@env != nil)
          @roof.environments << @env
        end
      end
    end

    if not params[:environment][:id].empty? and @roof.save
      redirect_to root_url
    else
      if (params[:environment][:id].empty?)
        flash.now[:error] = "Et valinnut ympäristöä"
      end
      render 'new'
    end
  end


  def update
    @roof = Roof.find(params[:id])

    params[:environment][:id].shift
    if not params[:environment][:id].empty?
      @roof.environments.clear
      params[:environment][:id].each do |env|
        @env = Environment.find_by_id(env)
        if (@env != nil)
          @roof.environments << @env
        end
      end
    end

    if  not params[:environment][:id].empty? and @roof.update_attributes(params[:roof])
      flash[:success] = "Tiedot päivitetty!"
      redirect_to :root
    else
      if (params[:environment][:id].empty?)
        flash.now[:error] = "Et valinnut ympäristöä"
      end
      render 'edit'
    end
  end

  def edit
    @roof = Roof.find_by_id(params[:id])
    @environments = Environment.all
  end
end
