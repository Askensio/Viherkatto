# encoding: UTF-8

class ContactsController < ApplicationController

  def edit
    if (!signed_in? || !current_user.admin?)
      redirect_to root_path
    else
      @contact = Contact.first
    end
  end

  def index
    @contact = Contact.first
  end

  def update
    @contact = Contact.first
    if @contact.update_attributes(params[:contacts])
      flash[:success] = "Tiedot päivitetty!"

      redirect_to contacts_path
    else
      render 'edit'
    end
  end

  def about
    render 'contact/about'
  end

end
