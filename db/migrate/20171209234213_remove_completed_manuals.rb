class RemoveCompletedManuals < ActiveRecord::Migration[5.1]
  def up
    remove_reference :completed_steps, :completed_manual, foreign_key: true
    drop_table :completed_manuals

    add_reference :completed_steps, :manual, foreign_key: true
  end

  def down
    create_table :completed_manuals do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :manual, foreign_key: true

      t.timestamps
    end

    remove_reference :completed_steps, :manual, foreign_key: true
    add_reference :completed_steps, :completed_manual, foreign_key: true
  end
end
