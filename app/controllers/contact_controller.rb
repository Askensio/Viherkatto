# encoding: UTF-8

class ContactController < ApplicationController
  def edit
  end

  def show
    @contact = Contact.find(1)
  end



end
