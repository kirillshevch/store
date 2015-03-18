class OrdersController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: "Access denied"
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
    coupon = Coupon.find_by(code: order_params[:coupon])
    if coupon
      if coupon.status
        order = current_order
        if order.update(coupon_id: coupon.id)
          redirect_to :back
        else
          redirect_to :back, alert: "Update error"
        end
      else
        redirect_to :back, alert: "Old coupon"
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
