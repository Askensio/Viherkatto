# encoding: UTF-8

class LayersController < ApplicationController
  require 'will_paginate/array'

  before_filter :admin_user, only: [:new,:create,:update,:edit]

  def new
    @layer = Layer.new
  end

  def create
    @layer = Layer.find_or_initialize_by_name_and_thickness_and_weight(params[:layer][:name], params[:layer][:thickness], params[:layer][:weight])
    isNew = @layer.new_record?
    if @layer.save
      if isNew
        redirect_to @layer
      else
        redirect_to layers_path
      end
    else
      render 'new'
    end
  end

  def show
    @layer = Layer.find(params[:id])
  end

  def index
    @layers = Layer.all(order: 'name, thickness, weight').paginate(page: params[:page])
  end

  def edit
    @layer = Layer.find(params[:id])
  end

  def update
    @layer = Layer.find(params[:id])
    if @layer.update_attributes(params[:layer])
      redirect_to @layer
    else
      render 'edit'
    end
  end
end
