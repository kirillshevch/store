class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :number
      t.integer :cvv
      t.integer :month
      t.integer :year
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
