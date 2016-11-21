class Product < ApplicationRecord
  belongs_to :category
  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  has_many :comments, -> order{ order 'created_at asc'}, as: :commentable, dependent: :destroy
end
