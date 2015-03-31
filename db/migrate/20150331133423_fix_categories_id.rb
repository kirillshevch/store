class FixCategoriesId < ActiveRecord::Migration
  def change
    remove_column :books, :categories_id
    add_column :books, :category_id, :integer
  end
end
