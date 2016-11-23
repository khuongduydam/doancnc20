class Category < ActiveRecord::Base
# class User < ActiveRecord::Base
  # attr_accessible 

  has_many :products, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures

end
