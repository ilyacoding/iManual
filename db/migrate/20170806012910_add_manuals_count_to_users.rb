class AddManualsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :manuals_count, :integer, default: 0, null: false
  end
end
