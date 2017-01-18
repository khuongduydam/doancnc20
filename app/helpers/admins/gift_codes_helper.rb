module Admins::GiftCodesHelper
  private
  def code(*number)
    Giftcode.all.map do |gift|
      number.map do |num|
        if gift.gift_code.size === num
          gift.gift_code 
        end
      end
    end
  end
end


