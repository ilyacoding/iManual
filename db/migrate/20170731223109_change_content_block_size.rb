class ChangeContentBlockSize < ActiveRecord::Migration[5.1]
  def change
    change_column :blocks, :content, :text
  end
end
