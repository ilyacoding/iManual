class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :name, null: false
      t.belongs_to :page, foreign_key: true

      t.timestamps
    end
  end
end
