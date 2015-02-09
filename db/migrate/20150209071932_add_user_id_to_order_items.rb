class AddUserIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :user_id, :integer
  end
end
