class Contact < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}  
  validates :address,  presence: true, length: {maximum: 255}
  validates :message,  presence: true, length: {minimum: 60}

  def self.search(search)
    if search
      where('LOWER(name) LIKE ? or LOWER(message) LIKE ?',"%#{search.downcase}%","%#{search.downcase}%")
    else
      # scoped
      all
    end
  end
end
