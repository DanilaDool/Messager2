class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :message, null: false, foreign_key: true
      t.index [:user_id, :message_id], unique: true

      t.timestamps
    end

    unless column_exists?(:messages, :likes_count)
      change_table :messages do |t|
        t.integer :likes_count, null: false, default: 0
      end
    end
  end
end
