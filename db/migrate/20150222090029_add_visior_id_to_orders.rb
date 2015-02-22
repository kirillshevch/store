class AddVisiorIdToOrders < ActiveRecord::Migration
  def change
    add_column :reviews, :visitor_id, :integer
  end
end
