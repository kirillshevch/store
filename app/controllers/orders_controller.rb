class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def delivery
    check_step_address
  end

  def confirm
    check_step_payment
  end

  def update
    current_order.update(delivery_params)
    #TODO послита комплита заказа отправлять на заказ
    redirect_to new_credit_card_url
  end

  private

    def check_step_address
      if current_order.shipping_address.nil?
        redirect_to new_address_url
      end
    end

    def check_step_payment
      if current_user.credit_card.nil?
        redirect_to new_credit_card_url
      end
    end

    def delivery_params
      params.require(:order).permit(:delivery, :state_id)
    end
end
