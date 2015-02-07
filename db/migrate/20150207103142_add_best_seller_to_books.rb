class AddBestSellerToBooks < ActiveRecord::Migration
  def change
    add_column :books, :best_seller, :boolean, default: false
  end
end
