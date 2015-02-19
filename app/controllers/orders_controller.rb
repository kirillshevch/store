class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def delivery
    check_step
    @order = current_order
  end

  def update
    current_order.update(params.require(:order).permit(:delivery))
    redirect_to credit_card_url
  end

  private

    def check_step
      if current_order.shipping_address == nil
        redirect_to addresses_url
      end
    end
end
