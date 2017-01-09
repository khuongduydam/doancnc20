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
      flash.now[:error] = "Can not send messages"
      render 'new'
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name,:address,:message)
  end
end