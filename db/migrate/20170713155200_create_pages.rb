class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.integer :pade_id

      t.timestamps
    end
  end
end
