# encoding: UTF-8

class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :authorized_user, only: [:edit, :update]
  before_filter :admin_user, only: [:index, :destroy]

  def index

    @jsonUsers = []
    respond_to do |format|
      @users = User.scoped
      format.html { render :html => @users } # index.html.erb

      @users = User.where('name like ?', '%' + params[:name].downcase + '%') if params[:name]
      @users = @users.where('email like ?', '%' + params[:email].downcase + '%') if params[:email]
      @users = @users.where('phone like ?', '%' + params[:phone].downcase + '%') if params[:phone]
      @users = @users.where('profession like ?', '%' + params[:profession].downcase + '%') if params[:profession]
      @users = @users.paginate(page: params[:page], per_page: params[:per_page]) if params[:page] and params[:per_page]

      @users = @users.select('id, name, admin, email').order('email ASC').all
      format.json { render :json => {admin: admin?, count: @users.total_entries, users: @users} }
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
    @user = User.find(params[:id])
  end

  def show
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      format.html { render :html => @user }
      format.json { render :json => {name: @user.name} }
    end
  end

  def destroy
    respond_to do |format|
      if User.find(params[:id]).destroy
        @response = "success"
      else
        @response = "error"
      end
      format.json { render :json => {response: @response} }
    end
  end

  def admin
    puts params[:id]
    respond_to do |format|
      @user = User.find(params[:id])
      if @user and @user.id != current_user.id
        @user.update_attribute(:admin, !@user.admin?)
        @user.save
      end
      format.json { render :json => @user.admin? }
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

  def authorized_user
    @user = User.find(params[:id])
    redirect_to (root_path) unless @user.id == current_user.id
  end
end

