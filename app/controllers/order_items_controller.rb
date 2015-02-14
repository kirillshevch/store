class OrderItemsController < ApplicationController
  def index
    if current_user
      @items = current_user.order_items.where(order_id: nil)
    end
  end

  def create
    if current_user
      current_user.order_items.create!(order_item_params)
      flash[:success] = t('add_to_cart')
      redirect_to :back
    end
  end

  def update
    if current_user
      current_user.order_items.find(params[:id]).update_attributes(order_item_params)
      redirect_to :back
    end
  end

  def destroy
    if current_user
      if params[:id] == "all"
        current_user.order_items.delete(:all)
        redirect_to :back
      else
        current_user.order_items.delete(params[:id])
        redirect_to :back
      end
    end
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end
end
