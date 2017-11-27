class AddStateToCompletedManuals < ActiveRecord::Migration[5.1]
  def change
    add_column :completed_manuals, :completed, :bool, default: false, null: false
  end
end
