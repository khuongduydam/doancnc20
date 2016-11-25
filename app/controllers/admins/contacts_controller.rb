class Admins::ContactsController < AdminsController
  def index
    @contacts = Contact.all.order(created_at: :desc)
  end
  def show
    @contact = Contact.find(params[:id])
  end
  def destroy
    Contact.find(params[:id]).delete
    flash[:success] = "Message deleted."
    redirect_to admins_contacts_path
  end
end