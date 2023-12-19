class AddRoomsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms_users, id: false do |t|
      t.belongs_to :room
      t.belongs_to :user
    end

    add_index :rooms_users, [:room_id, :user_id], unique: true
  end
end

