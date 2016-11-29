class Product < ActiveRecord::Base
  belongs_to :category
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  has_many :comments, -> order{ order 'created_at asc'}, as: :commentable, dependent: :destroy
  has_many :order_items
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  validates :name,  presence: true, uniqueness: {case_sensitive: false}
  validates_numericality_of :price,  presence: true, greater_than: 5000, less_than: 1000000
  validates :origin, presence: true, length: {minimum: 3}
  validates :description, presence: true, length: {minimum: 10}
  validates_numericality_of :quantity, greater_than: 0, less_than: 1000, presence: true
  
  before_destroy :ensure_not_referenced_by_any_order_item
  before_save :titleize_name

  def self.search(search)
    if search
      where('name LIKE ?',"%#{search}%")
    else
      all
    end
  end

  private
  def titleize_name
    self.name = name.titleize
  end
  def ensure_not_referenced_by_any_order_item
    if order_items.empty?
      return true
    else
      errors.add(:base, 'Order Items present')
      return false
    end
  end
end
