class OrderItemsController < ApplicationController
  def create
    if current_user

    else
      flash[:notice] = t('please_sign_up')
      redirect_to new_user_registration_url
    end
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
