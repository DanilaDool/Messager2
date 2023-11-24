class AddDescriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :descriptions, :string
  end
end
