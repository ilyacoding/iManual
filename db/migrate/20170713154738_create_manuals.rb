class CreateManuals < ActiveRecord::Migration[5.1]
  def change
    create_table :manuals do |t|
      t.string :name

      t.timestamps
    end
  end
end
