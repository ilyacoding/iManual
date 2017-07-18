class AddUserToManual < ActiveRecord::Migration[5.1]
  def change
    add_column :manuals, :user_id, :integer, null: false, dependent: :destroy
  end
end
