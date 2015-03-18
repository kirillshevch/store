class DeleteSecretKeyFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :secret_key
  end
end
