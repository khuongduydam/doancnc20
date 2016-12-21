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
  def self.search(search)
    if search
      where('LOWER(name) ILIKE ? or LOWER(address) ILIKE ? or LOWER(phone) ILIKE ? or LOWER(email) ILIKE ? or LOWER(status) ILIKE ? or LOWER(pay_type) ILIKE ?',"%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      # scoped
      all
    end
  end
end
