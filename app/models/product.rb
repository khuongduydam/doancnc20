class Product < ActiveRecord::Base
  belongs_to :category
  
  has_many :pictures, as: :imageable, dependent: :destroy
<<<<<<< HEAD

=======
>>>>>>> refactor
  has_many :wish_lists, dependent: :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  default_scope -> { order(created_at: :desc)}
  has_many :comments, -> order{ order 'created_at asc'}, as: :commentable, dependent: :destroy
end
