class AddPreviewToManuals < ActiveRecord::Migration[5.1]
  def change
    add_column :manuals, :preview, :string
  end
end
