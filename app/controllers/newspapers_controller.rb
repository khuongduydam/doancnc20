class NewspapersController < ApplicationController
  def show
    @newspaper = Newspaper.find(params[:id])
  end

  def index
    @newspapers = Newspaper.all
  end
end