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

  def index
    @bases = Base.paginate(page: params[:page])
  end

  def edit
    @base = Base.find(params[:id])
  end
end
