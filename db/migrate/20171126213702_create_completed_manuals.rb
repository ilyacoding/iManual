class CreateCompletedManuals < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_manuals do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :manual, foreign_key: true

      t.timestamps
    end
  end
end
