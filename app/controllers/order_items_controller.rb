class OrderItemsController < ApplicationController
  load_and_authorize_resource except: [:index, :destroy]
  before_action :order_update_price

  def index
    @items = current_order.order_items
  end

  def create
    item = current_order.order_items.build(order_item_params)
    if item.save
      flash[:success] = t('add_to_cart')
      redirect_to :back
    else
      redirect_to :back, alert: t('order_items.error_add')
    end
  end

  def update
    item = current_order.order_items.find(params[:id])
    if item.update_attributes(order_item_params)
      redirect_to :back
    else
      redirect_to :back, alert: t('order_items.error_upd')
    end
  end

  def destroy
    if params[:id] == "all"
      current_order.order_items.delete(:all)
      redirect_to :back
    else
      current_order.order_items.delete(params[:id])
      redirect_to :back
    end
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end

    def order_update_price
      current_order.count_price
      current_order.save
    end
end
