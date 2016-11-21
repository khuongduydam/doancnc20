class Product < ActiveRecord::Base
  belongs_to :category
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :wish_lists, dependent: :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  default_scope -> { order(created_at: :desc)}

end
