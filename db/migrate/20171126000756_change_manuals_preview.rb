class ChangeManualsPreview < ActiveRecord::Migration[5.1]
  def change
    change_column :manuals, :preview, :string, default: nil, null: true
  end
end
