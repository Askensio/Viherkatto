# encoding: UTF-8

class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def index
    @jsonUsers = []
    respond_to do |format|
      @users = User.paginate(page: params[:page])
      format.html { render :html => @users } # index.html.erb
      if params[:page].present?
        @jsonUsers = User.paginate(page: params[:page], per_page: params[:per_page])
      else
        @jsonUsers = User.all
      end

      @jsonUsersDub = [:User]

      if params[:name].present?
        @jsonUsers.each do |p|
          if !p.name.downcase.include?(params[:name].downcase)
            @jsonUsersDub << p
          end
        end
      end

      if params[:email].present?
        @jsonUsers.each do |p|
          if !p.email.downcase.include?(params[:email].downcase)
            @jsonUsersDub << p
          end
        end
      end

      if params[:phone].present?
        @jsonUsers.each do |p|
          if !p.phone.downcase.include?(params[:phone].downcase)
            @jsonUsersDub << p
          end
        end
      end

      if params[:profession].present?
        @jsonUsers.each do |p|
          if !p.profession.downcase.include?(params[:profession].downcase)
            @jsonUsersDub << p
          end
        end
      end


=begin
      if params[:admin].present?
        @jsonUsers.each do |p|
          if p.admin.to_i < params[:admin].to_i
            @jsonUsersDub << p
          end
        end
      end
=end
      puts @jsonUsers
      puts "Jamo<3"
      @jsonUsers -= @jsonUsersDub
      puts @jsonUsers
      puts "Jamox"
      puts @jsonUsersDub
      format.json { render :json => {admin: admin?, count: @users.total_entries, users: @jsonUsers} }
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    params[:user][:profession]
    if @user.save
      flash[:success] = "Tervetuloa käyttämään Viherkattotietokantaa " << @user.name.to_s << "!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Tiedot päivitetty!"
      sign_in @user
      redirect_to :root
    else
      render 'edit'
    end
  end

  def edit
    signed_in_user
    @user = User.find(params[:id])
  end

  def show
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      format.html { render :html => @user }
      format.json { render :json => {name: @user.name} }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :profession,
                                 :password, :password_confirmation)
  end

  def signed_in_user
    redirect_to kirjaudu_url,
                notice: "Kirjaudu sisään muokataksesi tietojasi" unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
