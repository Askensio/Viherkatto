# encoding: UTF-8

class UsersController < ApplicationController

  def new
    @user = User.new
    @ammatit = %w( donkey dog cat dolphin eagle )
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Tervetuloa käyttämään Viherkattotietokantaa!"
      redirect_to root_url
    else
      render 'new'
    end

  end
end
