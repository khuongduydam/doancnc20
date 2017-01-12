class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable,:database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2],
         :authentication_keys => [:username]
  enum role: [:member, :admin]

  validates :username, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :phone, numericality: {only_integer: true}
  validates_length_of :phone, minimum: 10, maximum: 11, allow_blank: true
  validates_length_of :password_confirmation, minimum: 6,on: :create
  has_many :wish_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_members,dependent: :destroy
  validates :password, :password_confirmation,length: {minimum: 6, maximum: 12}, on: :update, allow_blank: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.skip_confirmation!
    end
  end

  def self.from_omniauth_google(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      password = Devise.friendly_token[0,20]
      user = User.create(username: data["name"], email: data["email"],
        password: password, password_confirmation: password
      )
      user.skip_confirmation!
    end
    user
  end

  def self.from_google(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize do |user|
      user.email = auth[:info][:email]
    end
  end

  def self.search(search)
    if search
      where('LOWER(username) ILIKE ? or LOWER(email) ILIKE ? or LOWER(first_name) ILIKE ? or LOWER(last_name) ILIKE ?',"%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      # scoped
      all
    end
  end
end
