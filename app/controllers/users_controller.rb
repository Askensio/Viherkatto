# encoding: UTF-8

class UsersController < ApplicationController

  def new

    @user = User.new
    @positions = %w( Yksityisurakoitsija Yritys Tutkija Muu )
  end

  def create
    @user = User.new(params[:user])
    params[:user][:profession]
    if @user.save
      flash[:success] = "Tervetuloa käyttämään Viherkattotietokantaa!"
      redirect_to root_url
    else
      render 'new'
    end
  end
end
