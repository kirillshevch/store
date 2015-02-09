class OrderItemsController < ApplicationController
  def create
    if current_user
      current_user.order_items.create!(order_item_params)
      flash[:success] = t('add_to_cart')
      redirect_to :back
    else
      flash[:notice] = t('please_sign_up')
      redirect_to new_user_registration_url
    end
  end

  def show
    @items = current_user.order_items
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end
end
