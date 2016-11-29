class Newspaper < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  has_many :pictures, as: :imageable, dependent: :destroy
  
  validates :title,  presence: true, length: {minimum: 20, maximum: 255}
  validates :content,  presence: true, length: {minimum: 500}

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  before_save :upcase_firstcharac

  private
  def upcase_firstcharac
    self.title = title.capitalize
  end
end