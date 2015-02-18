class AddVisitorIdToAddressCreditCartOrder < ActiveRecord::Migration
  def change
    add_column :orders, :visitor_id, :integer
    add_column :billing_addresses, :visitor_id, :integer
    add_column :shipping_addresses, :visitor_id, :integer
    add_column :credit_cards, :visitor_id, :integer
  end
end
