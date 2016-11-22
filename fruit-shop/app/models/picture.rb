class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  mount_uploader :image, ImageUploader
end
