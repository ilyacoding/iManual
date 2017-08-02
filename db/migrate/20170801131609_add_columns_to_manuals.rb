class AddColumnsToManuals < ActiveRecord::Migration[5.1]
  def change
    add_reference :manuals, :category
    add_foreign_key :manuals, :categories
  end
end
