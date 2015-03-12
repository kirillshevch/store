class DeleteUserIdFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :user_id
  end
end
