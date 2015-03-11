class AddSecretKeyToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :secret_key, :string
  end
end
