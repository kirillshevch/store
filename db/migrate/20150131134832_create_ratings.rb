class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :review
      t.integer :number
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end
  end
end