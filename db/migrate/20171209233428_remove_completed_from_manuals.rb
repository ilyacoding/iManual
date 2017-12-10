class RemoveCompletedFromManuals < ActiveRecord::Migration[5.1]
  def change
    remove_column :completed_manuals, :completed
  end
end
