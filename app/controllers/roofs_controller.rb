# encoding: UTF-8

class RoofsController < ApplicationController

  def new
    @roof = Roof.new
    @environments = Environment.all
  end

  def create
    @roof = Roof.new(params[:roof])
    params[:environment][:id].shift
    params[:environment][:id].each do |env|
      @env = Environment.find_by_id(env)
      @roof.environments << @env
    end
    if (@roof.save)
      redirect_to root_url
    else
      if(params[:environment][:id].empty?)
        flash.now[:notice] = "Et valinnut ympäristöä"
      end
      render 'new'
    end
  end
end
