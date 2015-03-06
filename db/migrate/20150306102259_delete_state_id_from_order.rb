class DeleteStateIdFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :state_id
    add_column :orders, :state, :string
  end
end
