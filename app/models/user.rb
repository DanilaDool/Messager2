class User < ApplicationRecord
  has_many :requested_friendships, foreign_key: :requester_id, class_name: 'Friendship'
  has_many :received_friendships, foreign_key: :requested_id, class_name: 'Friendship'
  has_many :requested_friends, through: :requested_friendships, source: :requested
  has_many :received_friends, through: :received_friendships, source: :requester

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  def pending_friend_requests
    Friendship.where(requested_id: id, status: 'pending')
  end
end
