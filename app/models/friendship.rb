class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'

  scope :pending_requests_for, ->(user) { where(requested_id: user.id, accepted: false) }
end
