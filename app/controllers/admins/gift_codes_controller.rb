class Admins::GiftCodesController < ApplicationController
  def index
    render layout: 'layouts/admin_layout'
  end
  def create
    @gift_code = Giftcode.create!(gift_code: params[:code])
  end
end
