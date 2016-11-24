class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate :product_present, :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def product_present
    errors.add(:product, 'is not valid')
  end

  def order_present
    errors.add(:order, 'is not valid')
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantiy * self[:unit_price]
  end
end
