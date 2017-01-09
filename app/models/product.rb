class Product < ActiveRecord::Base
  belongs_to :category
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  has_many :comments, -> order{ order 'created_at desc'}, as: :commentable, dependent: :destroy
  has_many :order_items, dependent: :destroy
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  VALID_TEXT_REGEX = /\w+/
  validates :name,  presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_TEXT_REGEX, message: "can only contain letters and numbers."}
  validates_numericality_of :price,  presence: true,greater_than: 0
  validates_numericality_of :price_discount, allow_blank: true, less_than: :price
  validates :origin, presence: true, length: {minimum: 3}, format: {with: VALID_TEXT_REGEX, message: "can only contain letters and numbers."}
  validates :description, presence: true, length: {minimum: 10}, format: {with: VALID_TEXT_REGEX, message: "can only contain letters and numbers."}
  validates_numericality_of :quantity, greater_than: 0, less_than: 1001, presence: true
  
  before_destroy :ensure_not_referenced_by_any_order_item
  before_save :titleize_name

  def self.search(search)
    if search
      where('LOWER(name) ILIKE ? or LOWER(origin) ILIKE ?',"#{search}%","#{search}%")
    else
      # scoped
      all
    end
  end
  
  def self.search_filter(search, category, minValue, maxValue)
    if search.present? || category.present? || minValue.present? || maxValue.present?
      p "*"*80 
      p "VAO MODEL"
      p "*"*80 
      product = all

      product = where("LOWER(name) ILIKE ? or LOWER(origin) ILIKE ?","#{search}%","#{search}%") if search.present?
      product = product.where("category_id = ?", category) if category.present?
      if minValue.present? && maxValue.present?
        product = product.where("? <= price", minValue)
        product = product.where("price <= ?", maxValue)
      else
        product = product.where("price <= ?", minValue) if minValue.present?
        product = product.where("price >= ?", maxValue) if maxValue.present?
      end
      p "*"*80 
      p product
      p "*"*80 
      return product
    else
      all
    end
  end

  private

  def titleize_name
    self.name = name.mb_chars.titleize.to_s
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
