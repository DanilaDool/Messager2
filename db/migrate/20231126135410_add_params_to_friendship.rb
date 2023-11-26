class AddParamsToFriendship < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :requester_id, :integer
    add_column :friendships, :requested_id, :integer
    add_column :friendships, :status, :string
  end
end
