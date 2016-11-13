class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates(:name, length: {maximum: 50})
  VALID_NAME_REGEX = /[a-zA-Z]/
  # VALID_PHONE_REGEX = /\d/
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, :last_name, presence: true,length: {maximum: 30}, format: {with: VALID_NAME_REGEX}
  # validates :phone, length: {maximum: 20}, format: {with: VALID_PHONE_REGEX}

  extend Enumerize

  # enum sex: {other: 1, male: 2, female: 3}
  enumerize :sex, in: %w[other male female], default: :other
end
