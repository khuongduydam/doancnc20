class Newspaper < ApplicationRecord
  # ActionView::Base.full_sanitizer.sanitize(:content)
  default_scope -> { order(created_at: :desc) }

  validates :title,  presence: true, length: {minimum: 40, maximum: 255}
  validates :content,  presence: true, length: {minimum: 500}
end