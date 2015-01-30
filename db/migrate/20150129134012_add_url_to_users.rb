class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :url, :text
  end
end
