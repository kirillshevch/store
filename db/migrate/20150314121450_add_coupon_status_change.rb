class AddCouponStatusChange < ActiveRecord::Migration
  def change
    change_column_default :coupons, :status, true
  end
end
