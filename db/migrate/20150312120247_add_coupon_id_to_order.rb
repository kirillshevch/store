class AddCouponIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :coupon_id, :integer
  end
end
