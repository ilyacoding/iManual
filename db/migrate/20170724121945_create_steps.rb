class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :name, null: false
      t.bigint :priority, null: false
      t.belongs_to :manual, null: false

      t.timestamps
    end
  end
end
