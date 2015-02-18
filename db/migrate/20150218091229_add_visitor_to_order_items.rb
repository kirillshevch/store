class AddVisitorToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :visitor_id, :integer
  end
end
