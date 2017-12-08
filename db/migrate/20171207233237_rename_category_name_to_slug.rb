class RenameCategoryNameToSlug < ActiveRecord::Migration[5.1]
  def up
    rename_column :categories, :name, :slug

    Category.find_each do |category|
      category.update_attribute(:slug, category.slug.downcase)
    end
  end

  def down
    rename_column :categories, :slug, :name
  end
end
