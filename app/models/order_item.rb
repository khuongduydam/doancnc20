class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :order_member, optional: true
  validates_numericality_of :quantity, greater_than_or_equal_to: 0
  def total_price
    if product.price_discount.present?
      product.price_discount * quantity
    else
      product.price * quantity
    end
  end
end
