class Product < ActiveRecord::Base
  belongs_to :category
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  has_many :comments, -> order{ order 'created_at asc'}, as: :commentable, dependent: :destroy

  default_scope -> { order(created_at: :desc)}
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  validates :name,  presence: true, uniqueness: {case_sensitive: false}
  validates_numericality_of :price,  presence: true, greater_than: 5000, less_than: 1000000
  validates :origin, presence: true, length: {minimum: 3}
  validates :description, presence: true, length: {minimum: 10}
  validates_numericality_of :quantity, greater_than: 0, less_than: 1000, presence: true

  before_save :titleize_name

  private
  def titleize_name
    self.name = name.titleize
  end
end
