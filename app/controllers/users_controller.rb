# encoding: UTF-8

class UsersController < ApplicationController

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


end
