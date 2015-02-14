class AddFirstAndLastNameToAddresses < ActiveRecord::Migration
  def change
    add_column :billing_addresses,  :first_name, :string
    add_column :billing_addresses,  :last_name,  :string
    add_column :shipping_addresses, :first_name, :string
    add_column :shipping_addresses, :last_name,  :string
  end
end
