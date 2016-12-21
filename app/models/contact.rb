class Contact < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}  
  validates :address,  presence: true, length: {minimum: 3, maximum: 255}
  validates :message,  presence: true, length: {minimum: 20}

  def self.search(search)
    if search
      where('LOWER(name) ILIKE ? or LOWER(address) ILIKE ? or LOWER(message) ILIKE ?',"%#{search}%","%#{search}%","%#{search}%")
    else
      # scoped
      all
    end
  end
end
