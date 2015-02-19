class ChangeStructAddresses < ActiveRecord::Migration
  def change
    remove_columns :orders, :billing_address_id, :shipping_address_id
    add_column :billing_addresses, :order_id, :integer
    add_column :shipping_addresses, :order_id, :integer
  end
end
