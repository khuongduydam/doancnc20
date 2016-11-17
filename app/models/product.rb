class Product < ApplicationRecord
  belongs_to :category

  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
end
