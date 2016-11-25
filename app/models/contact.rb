class Contact < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}  
  validates :address,  presence: true, length: {maximum: 255}
  validates :message,  presence: true, length: {minimum: 60}
end
