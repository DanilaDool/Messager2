class Room < ApplicationRecord
  has_many :messages, -> { sorted }, dependent: :destroy
  belongs_to :user
  before_create {self.title = SecureRandom.hex(3)}
  has_many :rooms_users
  has_many :users, through: :rooms_users
  has_and_belongs_to_many :users
end
