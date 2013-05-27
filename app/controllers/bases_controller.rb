# encoding: UTF-8

class BasesController < ApplicationController
  require 'will_paginate/array'

  def new
    @base = Base.new
  end

=begin
def create
    @base = Base.new(params[:base])
    if @base.save
      redirect_to @base
    else
      render 'new'
    end
  end
=end

=begin
  def create
    result = Base.find(params[:base])
    if result.nil?
      @base = Base.new(params[:base])
      if @base.save
        redirect_to @base
      end
    else
      render 'new'
    end
  end
=end

  def create
    @base = Base.find_or_initialize_by_material_and_thickness_and_absorbancy_and_weight(params[:base][:material], params[:base][:thickness], params[:base][:absorbancy], params[:base][:weight])
    if @base.save
      redirect_to @base
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
end
