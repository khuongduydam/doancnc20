class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Message sended"
      redirect_to root_path
    else
      p "*"*50
      p @contact.errors.messages
      p "*"*50
      render 'new'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name,:address,:message)
  end
end