class GreenroofsController < ApplicationController


  def show
    @greenroof = Greenroof.find(params[:id])
  end

  def new
    @greenroof = Greenroof.new
    @base = Base.new
    @roof = Roof.new
    @environments = Environment.all
    @layer = Layer.new
    @base = Base.new
  end

  def create
    if true
      render 'new'
    end
  end
end
