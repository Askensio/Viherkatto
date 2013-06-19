# encoding: UTF-8

require 'RMagick'

class GreenroofsController < ApplicationController

  before_filter :signed_user, only: [:new, :create]
  before_filter :owner, only: [:upload]
  before_filter :user_with_edit_rights, only: [:edit]

  def search

    respond_to do |format|

      format.html { render :html => {greenroofs: @greenroofs} }

      @greenroofs = Greenroof.scoped
      if params[:address]
        address = "%#{params[:address]}%"
        @greenroofs = @greenroofs.where("address like ?", address)
      end
      if params[:groofnote]
        groofnote = "%#{params[:groofnote]}%"
        @greenroofs = @greenroofs.where("greenroofs.note like ?", groofnote)
      end
      if params[:plantname]
        plantname = "%#{params[:plantname]}%"
        @greenroofs = @greenroofs.joins(:plants).where("plants.name like ?", plantname)
      end
      if params[:maintenance]
        maintenance = params[:maintenance].to_i
        @greenroofs = @greenroofs.joins(:plants).where("plants.maintenance = ?", maintenance)
      end
      @greenroofs = @greenroofs.joins(:plants).where("plants.max_height <= ?", params[:plantmaxheight]) if params[:plantmaxheight]
      @greenroofs = @greenroofs.joins(:plants).where("plants.min_height >= ?", params[:plantminheight]) if params[:plantminheight]
      if params[:envname]
        envname = "%#{params[:envname]}%"
        @greenroofs = @greenroofs.joins(:roof).joins(:roof => :environments).where("environments.name like ?", envname)
      end
      @greenroofs = @greenroofs.joins(:roof).where("roofs.declination <= ?", params[:maxdeclination]) if params[:maxdeclination]
      @greenroofs = @greenroofs.joins(:roof).where("roofs.load_capacity >= ?", params[:minload_capacity]) if params[:minload_capacity]
      @greenroofs = @greenroofs.joins(:roof).where("roofs.area >= ?", params[:minroofarea]) if params[:minroofarea]
      @greenroofs = @greenroofs.joins(:roof).where("roofs.area <= ?", params[:maxroofarea]) if params[:maxroofarea]
      if params[:layername]
        layername = "%#{params[:layername]}%"
        @greenroofs = @greenroofs.joins(:layers).where("layers.name like ?", layername)
      end

      @greenroofs = @greenroofs.paginate(page: params[:page], per_page: params[:per_page]) unless @greenroofs.nil?
      @count = @greenroofs.total_entries
=begin
      if params[:colour]
        colour = "%#{params[:colour]}%"
        @greenroofs = @greenroofs.joins(:plants).where("plants.colour like ?", colour)
      end
=end
      #@greenroofs = @greenroofs.joins(:bases).where("bases.absorbancy >= ?", params[:minabsorbancy]) if params[:minabsorbancy]
      #@greenroofs = @greenroofs.joins(:layers).sum("layers.thickness => ?", params[:minthickness]) if params[:minthickness]

      #Plant.where("name like ?", name).map{ |plant| plant.greenroofs }.flatten! if params[:name]


      @jsonGreenroofs = []

      @greenroofarray = @greenroofs.to_a
      @greenroofarray.each do |groof|
        @user = User.find_by_id(groof.user_id)
        jsonGreenroof = groof.attributes
        jsonGreenroof[:user] = @user.name
        @jsonGreenroofs << jsonGreenroof
      end

      format.json { render :json => {admin: admin?, count: @count, greenroofs: @jsonGreenroofs} }

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

    if not params[:customPlants].nil?
      params[:customPlants].each do |cplant|
        cplant[1].each do |toAddPlant|
          @cplant = CustomPlant.new(name: toAddPlant)
          @greenroof.custom_plants << @cplant
        end
      end
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
      respond_to do |format|
        format.json { render :json => {id: @greenroof.id} }
      end

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


      # TÄMÄ FUNKTIO TURHA KUN VIHERKATOLLA ON OMISTAJA KENTTÄ
      @greenroofs.each do |groof|
        @user = User.find_by_id(groof.user_id)
        hash = groof.attributes
        hash[:thumb] = groof.images.first.thumb unless groof.images.first.nil?
        hash[:user] = @user.name unless @user.nil?
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

    @greenroof = Greenroof.find(params[:id])
    respond_to do |format|
      @response = ""
      if (@greenroof.user_id == current_user.id) or current_user.admin?
        @greenroof.destroy
        @response = "success"
      else
        @response = "error"
      end

      format.json { render :json => {response: @response} }
    end
  end

  def upload
    @groof = Greenroof.find_by_id(params[:id])

    unless params["file-0"].nil?
      # The path to the directory for the photos of the created greenroof.
      directory = "/public/greenroofs/photos/" + params[:id]

      # If the directory does not exists a new one will be created.
      FileUtils.mkdir_p Dir.pwd + directory if not File.directory? Dir.pwd + directory

      # The filename for the new photo.
      photoFilename = params[:id] + "_" + Time.now.to_i.to_s + "_" + Digest::MD5.hexdigest(params["file-0"].original_filename)

      # The full path for the photo.
      photoPath = Dir.pwd + directory + "/" + photoFilename

      file = File.read(params["file-0"].tempfile) if params["file-0"]
      f = File.new(photoPath, "w+")
      f.write file
      f.close

      # Filename for the thumbnail
      thumbFilename = params[:id] + "_thumb_" + Time.now.to_i.to_s + "_" + Digest::MD5.hexdigest(params["file-0"].original_filename)

      thumb = Magick::Image.read(photoPath).first
      thumb.crop_resized!(120, 120, Magick::NorthGravity)
      thumbPath = Dir.pwd + directory + "/" + thumbFilename
      thumb.write(thumbPath)

      # photo = "/photos/" + params[:id]

      img = Image.new(photo: photoFilename, thumb: thumbFilename)
      @groof.images << img
    end
    if @groof.save!
      flash[:success] = "Viherkaton lisäys onnistui!"
      render :js => "window.location = '/'"
    end
  end

  def edit
    @greenroof = Greenroof.find(params[:id])
    @roof = @greenroof.roof
    respond_to do |format|
      format.json {render :json => {plants: @greenroof.plants }}
      format.html { render :html => @greenroof } # index.html.erb
    end
  end

  private

  def owner
    unless Greenroof.find_by_id(params[:id]).user_id == current_user.id
      redirect_to root_url
    end
  end

  def user_with_edit_rights
    @greenroof = Greenroof.find(params[:id])
    redirect_to root_path unless (signed_in? && (current_user.email == @greenroof.user.email || admin?))
  end



end
