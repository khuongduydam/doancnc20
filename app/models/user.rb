class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]
  enum role: [:member, :admin]
  validates :username, presence: true, uniqueness: true
  validates :phone, numericality: {only_integer: true}
  validates_length_of :phone, minimum: 10, maximum: 11, allow_blank: true

  has_many :comments, as: :commentable
end
