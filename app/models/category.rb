class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
end
