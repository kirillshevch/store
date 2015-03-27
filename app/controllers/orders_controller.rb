class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user
      @orders = current_user.orders
    else
      redirect_to new_user_registration_url, notice: t('checkout.sign_up_view_order')
    end
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
          redirect_to :back, alert: t('orders.upd_error')
        end
      else
        redirect_to :back, alert: t('orders.old_coupon')
      end
    else
      redirect_to :back, alert: t('orders.undefined_coupon')
    end
  end

  private

    def order_params
      params.require(:order).permit(:coupon)
    end
end
