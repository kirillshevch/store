class AddDeliveryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery, :integer
  end
end
