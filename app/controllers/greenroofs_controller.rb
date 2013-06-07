# encoding: UTF-8

class GreenroofsController < ApplicationController

  before_filter :signed_user, only: [:new, :create]

  def search
    unless params
      @greenroofs = Greenroof.paginate(page: params[:page], per_page: params[:per_page])
    else
      @greenroofs = Greenroof.scoped
      #puts(@greenroofs.first[:address])
      if params[:address]
        address = "%#{params[:address]}%"
        @greenroofs = @greenroofs.where("address like ?", address)
      end
      if params[:groofnote]
        groofnote = "%#{params[:groofnote]}%"
        @greenroofs = @greenroofs.where("note like ?", groofnote)
      end
      if params[:plantname]
        plantname = "%#{params[:plantname]}%"
        @greenroofs = @greenroofs.includes(:plants).where("plants.name like ?", plantname)
      end
      if params[:colour]
        colour = "%#{params[:colour]}%"
        @greenroofs = @greenroofs.includes(:plants).where("plants.colour like ?", colour)
      end
      @greenroofs = @greenroofs.includes(:plants).where("plants.maintenance = ?", params[:maintenance]) if params[:maintenance]
      @greenroofs = @greenroofs.includes(:plants).where("plants.height <= ?", params[:plantmaxheight]) if params[:plantmaxheight]
      @greenroofs = @greenroofs.includes(:plants).where("plants.height >= ?", params[:plantminheight]) if params[:plantminheight]
      if params[:envname]
        env = "%#{params[:envname]}%"
        @greenroofs = @greenroofs.includes(:environments).where("environments.name like ?", env)
      end
      #@greenroofs = @greenroofs.includes(:roofs).where("roofs.declination <= ?", params[:maxdeclination]) if params[:maxdeclination]
      #@greenroofs = @greenroofs.includes(:roofs).where("roofs.load_capacity >= ?", params[:minload_capacity]) if params[:minload_capacity]
      #@greenroofs = @greenroofs.includes(:roofs).where("roofs.area >= ?", params[:minroofarea]) if params[:minroofarea]
      #@greenroofs = @greenroofs.includes(:roofs).where("roofs.area <= ?", params[:maxroofarea]) if params[:maxroofarea]
      #@greenroofs = @greenroofs.includes(:bases).where("bases.absorbancy >= ?", params[:minabsorbancy]) if params[:minabsorbancy]
      if params[:layername]
        layername = "%#{params[:layername]}%"
        @greenroofs = @greenroofs.includes(:layers).where("layers.name like ?", layername)
      end
      #@greenroofs = @greenroofs.includes(:layers).sum("layers.thickness => ?", params[:minthickness]) if params[:minthickness]
      @greenroofs.paginate(page: params[:page], per_page: params[:per_page])
      #Plant.where("name like ?", name).map{ |plant| plant.greenroofs }.flatten! if params[:name]
    end
  end

  def show
    @greenroof = Greenroof.find(params[:id])
  end


  def new
    @greenroof = Greenroof.new
    @base = Base.new
    @layer = Layer.new

    @base.layers << @layer

    @roof = Roof.new
    @greenroof.bases << @base
    @greenroof.roof = @roof
    @environments = Environment.all
  end

  def create

    @greenroof = Greenroof.new(params[:greenroof])
    @greenroof.user = current_user


    @roof = Roof.new(params[:roof])

    if not params[:environment].nil?
      params[:environment][:id].shift
      params[:environment][:id].each do |env|
        @env = Environment.find_by_id(env)
        if (@env != nil)
          @roof.environments << @env
        end
      end
    else
      flash.now[:error] = "Et valinnut ympäristöä."
      respond_to do |format|
        #format.js { render :action => 'new' }
      end
      return
    end

    @greenroof.roof = @roof

    @bases = params[:bases]
    @bases.each do |key, value|
      @base = Base.new(value[:base])
      if not value[:layers].nil?
        value[:layers].each do |key, value|
          @layer = Layer.new(value)
          @base.layers << @layer
        end
      end
      @greenroof.bases << @base
    end


    if params[:plants].nil?
      #flash.now[:error] = "Et lisännyt yhtään kasvia."
      respond_to do |format|
        #format.js { render :action => 'new' }
      end
      return
    else
      params[:plants].each do |id|
        @plant = Plant.find_by_id(id)
        if not @plant.nil?
          @greenroof.plants << @plant
        end
      end
    end

    if @greenroof.save!
      flash[:success] = "Viherkaton lisäys onnistui!"
      render :js => "window.location = '/'"

    else
      if not params[:plants].nil? and not params[:environment][:id].empty?
        respond_to do |format|
          #format.js { render :action => 'new' }
        end
      end
    end
  end

  def index
    respond_to do |format|
      #@greenroofs = Greenroof.paginate(page: params[:page])
      #@greenroofs = Greenroof.all


      @count = 0
      if params[:page].present?
        @greenroofs = Greenroof.paginate(page: params[:page], per_page: params[:per_page])
        @count = @greenroofs.total_entries
      else
        @greenroofs = Greenroof.all
        @count = @greenroofs.length
      end

      format.html { render :html => @greenroofs } # index.html.erb

      @jsonGreenroofs = []



      @greenroofs.each do |groof|
        @user = User.find_by_id(groof.user_id)
        hash = groof.attributes
        hash[:user] = @user.name
        if (signed_in?)
          hash[:owner] = (@user.id == current_user.id)
        else
          hash[:owner] = false
        end
        @jsonGreenroofs << hash
      end

      @jsonUser = User.all

      #format.json { render :json => {count: @greenroofs.total_entries, greenroofs: @jsonGreenroofs} }
      format.json { render :json => {admin: admin?, count: @count, greenroofs: @jsonGreenroofs} }
    end
  end

  def destroy
    puts "jou mään tsikakooo"
    @greenroof = Greenroof.find(params[:id])
    respond_to do |format|

      if @greenroof.user_id == current_user.id
        @greenroof.destroy
        format.js { render "success" }
      else
        format.js { render "fail" }
      end
    end
  end
end
