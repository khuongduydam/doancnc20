class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable

  accepts_nested_attributes_for :pictures,:allow_destroy => true

  validates :name,  presence: true, length: { maximum: 50 }
  validates_associated :pictures
  before_save :titleize_name

  private
  def titleize_name
    self.name = name.titleize
  end
end
