class AddBookIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :book_id, :integer
  end
end
