class AddManualToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :manual
    add_foreign_key :comments, :manuals
  end
end
