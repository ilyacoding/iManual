class AddInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :about, :text
    add_column :users, :interests, :text
  end
end
