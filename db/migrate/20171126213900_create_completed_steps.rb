class CreateCompletedSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_steps do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :step, foreign_key: true
      t.belongs_to :completed_manual, foreign_key: true

      t.timestamps
    end
  end
end
