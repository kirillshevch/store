class OrdersController < ApplicationController

  def index
    @orders = Order.accessible_by(current_ability)
  end

  def show
    @order = current_user.orders.find(params[:id])
    authorize! :read, @order
  end

  def update
    coupon = Coupon.find_by(code: order_params[:coupon])
    if coupon
      if coupon.status
        order = current_order
        authorize! :update, order
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
