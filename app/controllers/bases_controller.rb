class BasesController < ApplicationController
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

  def create
    result = Base.find_or_create(:material => params[:base][:material])
    if result.nil?
      @base = Base.new(params[:base])
      if @base.save
        redirect_to @base
      end
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
