# encoding: UTF-8

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = 'Tervetuloa ' << user.name << '.'
      redirect_to root_url
    else
      flash.now[:error] = 'Virheellinen sähköposti/salasana yhdistelmä.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end