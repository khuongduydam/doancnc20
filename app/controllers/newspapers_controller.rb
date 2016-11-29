class NewspapersController < ApplicationController
  def show
    @newspaper = Newspaper.find(params[:id])
  end

  def index
    @newspapers = Newspaper.all.order(created_at: :desc).paginate(:per_page => 10, :page => params[:page])
  end
end