class WishlistsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :index]
  
  def index
    @wishlistss = WishList.where(user_id: current_user.id).order(created_at: :desc)..paginate(:per_page => 10, :page => params[:page])
  end

  def create
    @wishlist = WishList.new
    @wishlist.product_id=params[:format]
    @wishlist.user_id=current_user.id
    if @wishlist.save
      flash[:success] = "Add to wishlist success"
      redirect_to(:back)
    else
      p "*"*50
      p @wishlist.errors.messages
      p "*"*50
      redirect_to root_path
    end
  end
  def destroy
    WishList.find(params[:id]).destroy
    flash[:success] = "Product in wishlist has deleted"
    redirect_to wishlists_path
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to new_user_session_path
      end
    end
    def logged_in?
      !current_user.nil?
    end
    def store_location
      session[:forwarding_url]  = request.original_url if request.get?
    end
end