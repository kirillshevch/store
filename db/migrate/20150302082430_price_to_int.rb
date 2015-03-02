class PriceToInt < ActiveRecord::Migration
  def change
    remove_column :order_items, :price, :integer
    remove_column :orders, :price, :integer
    add_column :order_items, :price, :integer
    add_column :orders, :price, :integer
  end
end
