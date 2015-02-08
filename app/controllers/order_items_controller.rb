class OrderItemsController < ApplicationController
  def create

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
