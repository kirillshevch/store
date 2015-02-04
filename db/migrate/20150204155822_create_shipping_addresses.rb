class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :address
      t.integer :zipcode
      t.string :city
      t.string :phone
      t.belongs_to :country, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
