class AddAcceptedToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :accepted, :boolean
  end
end
