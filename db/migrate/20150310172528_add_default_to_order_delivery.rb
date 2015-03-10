class AddDefaultToOrderDelivery < ActiveRecord::Migration
  def change
    remove_column :orders, :delivery
    add_column :orders, :delivery, :integer, default: 0
  end
end
