class CreateRails < ActiveRecord::Migration[5.1]
  def change
    create_table :rails do |t|
      t.string :g
      t.string :scaffold
      t.string :User
      t.string :username
      t.string :nickname
      t.string :provider
      t.string :url

      t.timestamps
    end
  end
end
