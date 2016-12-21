class Newspaper < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  has_many :pictures, as: :imageable, dependent: :destroy
  
  VALID_TEXT_REGEX = /\w+/
  validates :title,  presence: true, length: {minimum: 10, maximum: 255}, format: {with: VALID_TEXT_REGEX, message: "can only contain letters and numbers."}
  validates :content,  presence: true, length: {minimum: 500}

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  before_save :titleize_firstcharac

  def self.search(search)
    if search
      where('LOWER(title) ILIKE ? or LOWER(content) ILIKE ?',"%#{search}%","%#{search}%")
    else
      # scoped
      all
    end
  end

  private
  def titleize_firstcharac
    self.title = title.mb_chars.titleize.to_s
  end
end