class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'

  scope :pending_requests_for, ->(user) { where(requested_id: user.id, status: 'pending') }

  def create_room_for_friendship
    room = Room.create(user_id: requester_id, title: "Room_#{SecureRandom.hex(3)}")
  end

end
