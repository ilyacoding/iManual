class AddUserToManuals < ActiveRecord::Migration[5.1]
  def change
    add_reference :manuals, :user, index: true
    add_foreign_key :manuals, :users
  end
end
