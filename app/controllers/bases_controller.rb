class BasesController < ApplicationController
  def new
    @base = Base.new
  end

  def create
    @base = Base.new(params[:base])
    if @base.save
      redirect_to @base
    else
      render 'new'
    end
  end

  def show
    @base = Base.find(params[:id])
  end
end
