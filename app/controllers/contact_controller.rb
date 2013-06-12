# encoding: UTF-8

class ContactController < ApplicationController

  def edit

    if (!signed_in? || !current_user.admin?)
      redirect_to root_path
    else
      @contact = Contact.find(1)
    end
  end

  def show
    @contact = Contact.find(1)
  end

  def update
    @contact = Contact.find(1)
    if @contact.update_attributes(params[:contact])
      flash[:success] = "Tiedot päivitetty!"

      redirect_to contact_path
    else
      render 'edit'
    end
  end

       private



end
