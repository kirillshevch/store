class OrdersController < ApplicationController
  load_and_authorize_resource except: :update

  def index
  end

  def show
  end

  def update
    coupon = Coupon.find_by(code: order_params[:coupon])
    if coupon
      if coupon.status
        order = current_order
        if order.update(coupon_id: coupon.id)
          redirect_to cart_url
        else
          redirect_to cart_url, alert: t('orders.upd_error')
        end
      else
        redirect_to cart_url, alert: t('orders.old_coupon')
      end
    else
      redirect_to cart_url, alert: t('orders.undefined_coupon')
    end
  end

  private

    def order_params
      params.require(:order).permit(:coupon)
    end
end
