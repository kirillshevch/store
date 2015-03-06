class RemoveVisitorFromTables < ActiveRecord::Migration
  def change
    remove_column :billing_addresses, :visitor_id
    remove_column :credit_cards, :visitor_id
    remove_column :order_items, :visitor_id
    remove_column :orders, :visitor_id
    remove_column :reviews, :visitor_id
    remove_column :shipping_addresses, :visitor_id
  end
end
