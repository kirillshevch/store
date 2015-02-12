class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :short_description
      t.text :full_description
      t.belongs_to :author, index: true
      t.belongs_to :categories, index: true
      t.string :image
      t.integer :price

      t.timestamps
    end
  end
end
