class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :requested_friendships, foreign_key: :requester_id, class_name: 'Friendship'
  has_many :received_friendships, foreign_key: :requested_id, class_name: 'Friendship'
  has_many :requested_friends, through: :requested_friendships, source: :requested
  has_many :received_friends, through: :received_friendships, source: :requester
  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_and_belongs_to_many :rooms

  before_validation :set_default_name, on: :create

  validates :name, presence: true

  mount_uploader :avatar, AvatarUploader

  def pending_friend_requests
    Friendship.where(requested_id: id, status: 'pending')
  end

  def friends
    received_friends.where(friendships: { status: 'accepted' })
  end

  private

  def set_default_name
    self.name ||= "User-#{SecureRandom.hex(3)}"
  end


end
