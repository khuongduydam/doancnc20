class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :order_member, optional: true
  def total_price
    if product.price_discount.present?
      product.price_discount * quantity
    else
      product.price * quantity
    end
  end
end
