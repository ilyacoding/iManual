class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.string :content, null: false
      t.bigint :priority, null: false
      t.string :type
      t.belongs_to :step, foreign_key: true

      t.timestamps
    end
  end
end
