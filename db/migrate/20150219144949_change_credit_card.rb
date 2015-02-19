class ChangeCreditCard < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :number
    add_column :credit_cards, :number, :string
  end
end
