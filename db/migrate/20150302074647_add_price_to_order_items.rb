class AddPriceToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :price, :float
    remove_column :orders, :total_price
    add_column :orders, :price, :float
  end
end
