class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  PAYMENT_TYPES = ['Paypal' ,'Direct']
  validates :name, :address, :email, :phone, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_order_items_from_cart(cart)
    cart.order_items.each do |item|
      order_items << item
      item.cart_id = nil
    end
  end
end
