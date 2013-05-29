# encoding: UTF-8

class BasesController < ApplicationController
  require 'will_paginate/array'

  before_filter :admin_user, only: [:new,:create,:update,:edit]

  def new
    @base = Base.new
  end

  def create
    @base = Base.find_or_initialize_by_material_and_thickness_and_absorbancy_and_weight(params[:base][:material], params[:base][:thickness], params[:base][:absorbancy], params[:base][:weight])
    isNew = @base.new_record?
    if @base.save
      if isNew
        redirect_to @base
      else
        redirect_to bases_path
      end
    else
      render 'new'
    end
  end

  def show
    @base = Base.find(params[:id])
  end

  def index
    @bases = Base.all(order: 'material, thickness, absorbancy, weight').paginate(page: params[:page])
  end

  def edit
    @base = Base.find(params[:id])
  end

  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(params[:base])
       redirect_to @base
    else
       render 'edit'
    end
  end

end
