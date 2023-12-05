class Message < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :room
  belongs_to :user

  scope :sorted, ->  { order(:id)}
  validates :body, presence: true
end
