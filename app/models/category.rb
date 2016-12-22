class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable

  accepts_nested_attributes_for :pictures,:allow_destroy => true

  VALID_NAME_REGEX = /\w+/
  validates :name,  presence: true, length: {minimum: 2, maximum: 50 }, uniqueness: {case_sensitive: false}, format: {with: VALID_NAME_REGEX, message: "can only contain letters and numbers." }
  validates_associated :pictures
  before_save :titleize_name

  def self.search(search)
    if search
      joins('LEFT JOIN products on categories.id = products.category_id').where('LOWER(categories.name) LIKE ?',"%#{search.downcase}%").select("categories.name AS name_cat, products.category_id, count(products.category_id ) as sl").group('products.category_id , categories.name')
    else
      # scoped
      all
    end
  end

  private
  def titleize_name
    self.name = name.mb_chars.titleize.to_s
  end
end
