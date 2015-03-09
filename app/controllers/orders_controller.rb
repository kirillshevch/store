class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
  end

  private

    def delivery_params
      params.require(:order).permit(:state)
    end

end
