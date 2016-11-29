class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  mount_uploader :image, ImageUploader
  validates :image, presence: true
  # validates_presence_of :image
end
