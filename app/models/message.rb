class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  scope :sorted, ->  { order(:id)}

  validates :body, presence: true, unless: :image_attached?

  mount_uploader :image, ImageUploader

  def image_attached?
    self.image.present? && self.image.file.present?
  end
end