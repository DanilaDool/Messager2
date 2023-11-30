class AddSentRequestToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :sent_request, :boolean
  end
end
