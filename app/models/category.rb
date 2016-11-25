class Category < ActiveRecord::Base
  # include ActiveModel::Validation
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable

  accepts_nested_attributes_for :pictures,:allow_destroy => true

  validates :name,  presence: true, length: { maximum: 50 }

  before_save :titleize_name

  private
  def titleize_name
    self.name = name.titleize
  end
end
