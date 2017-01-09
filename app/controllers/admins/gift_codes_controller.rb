class Admins::GiftCodesController < ApplicationController
  def index
    render layout: 'layouts/admin_layout'
  end
  def create
    begin
      @gift_code = Giftcode.create!(gift_code: params[:code])
    rescue
      flash.now[:error] = 'Can not create more gift code'
    end
  end
end
