class DeleteCreditCardFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :credit_card_id
  end
end
