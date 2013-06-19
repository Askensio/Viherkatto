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
    respond_to do |format|
      @bases = Base.paginate(page: params[:page])
      format.html { render :html => @bases } # index.html.erb
      if params[:page].present?
        @jsonBases = Base.paginate(page: params[:page], per_page: params[:per_page])
      else
        @jsonBases = Base.all
      end

      format.json { render :json => {admin: admin?, count: @jsonBases.total_entries, bases: @jsonBases} }
    end
  end

  def show
  end

  def edit
  end
end
