class OrdersController < ApplicationController
  def index
    if current_order
      @orders = current_user.orders
    else
      redirect_to new_user_registration_url, alert: "Sign up to view the order"
    end
  end

  def show
    if current_order
      @order = current_user.orders.find(params[:id])
    else
      redirect_to new_user_registration_url, alert: "Sign up to view the order"
    end
  end

  def update
    coupon = Coupon.find_by(code: order_params[:coupon])
    if coupon
      order = current_order
      if order.update(coupon_id: coupon.id)
        redirect_to :back
      else
        redirect_to :back, alert: "Update error"
      end
    else
      redirect_to :back, alert: "Undefined coupon"
    end
  end

  private

    def order_params
      params.require(:order).permit(:coupon)
    end
end
