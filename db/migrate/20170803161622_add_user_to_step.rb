class AddUserToStep < ActiveRecord::Migration[5.1]
  def change
    add_reference :steps, :user, index: true
    add_foreign_key :steps, :users
  end
end
