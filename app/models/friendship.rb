class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'

  scope :pending_requests_for, ->(user) { where(requested_id: user.id, status: 'pending') }

  def create_room_for_friendship(user_id1, user_id2)
    room = Room.create(user_id: user_id1, title: "Room_#{SecureRandom.hex(3)}")
    room.users << [User.find(user_id1), User.find(user_id2)]
  end
end
