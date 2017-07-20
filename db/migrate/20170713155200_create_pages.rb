class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.integer :priority, null: false
      t.belongs_to :manual, foreign_key: true

      t.timestamps
    end
  end
end
