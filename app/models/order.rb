class Order < ApplicationRecord
  belongs_to :user, :order_status
  has_many :order_details
  before_create :set_order_status
  belongs_save :update_subtotal

  def subtotal
    order_details.map{|od| od.valid? ? (od.quantity * od.price) : 0}.sum
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
