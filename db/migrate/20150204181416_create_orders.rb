class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :total_price
      t.date :completed_date
      t.belongs_to :state, index: true
      t.belongs_to :user, index: true
      t.belongs_to :credit_card, index: true

      t.timestamps
    end
  end
end
