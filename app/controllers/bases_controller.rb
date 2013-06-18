# encoding: UTF-8

class BasesController < ApplicationController
  def new
    @base = Base.new
  end

  def create
    @base = Base.new(params[:base])

    params[:layers].each do |key, layer|
      @base.layers << Layer.new(layer)
    end

    if @base.save!
      flash[:success] = "Lisäys onnistui!"
      render :js => "window.location = '/bases'"
    else
      render 'new'
    end
  end

  def index
  end

  def show
  end

  def edit
  end
end
