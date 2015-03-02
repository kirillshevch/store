class ZipCodeToString < ActiveRecord::Migration
  def change
    remove_column :billing_addresses, :zipcode
    remove_column :shipping_addresses, :zipcode
    add_column :billing_addresses, :zipcode, :string
    add_column :shipping_addresses, :zipcode, :string
  end
end
