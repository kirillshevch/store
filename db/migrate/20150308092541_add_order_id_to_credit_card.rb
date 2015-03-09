class AddOrderIdToCreditCard < ActiveRecord::Migration
  def change
    add_column :credit_cards, :order_id, :integer
  end
end
