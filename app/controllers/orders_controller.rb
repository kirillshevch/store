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
end
