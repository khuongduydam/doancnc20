class Product < ActiveRecord::Base
  belongs_to :category
  
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  default_scope -> { order(created_at: :desc)}
  has_many :comments, -> order{ order 'created_at asc'}, as: :commentable, dependent: :destroy
  has_many :order_items
  before_destroy :ensure_not_referenced_by_any_order_item

  private
  def ensure_not_referenced_by_any_order_item
    if order_items.empty?
      return true
    else
      errors.add(:base, 'Order Items present')
      return false
    end
  end
end
