class Users::SessionsController < Devise::SessionsController

  after_action :set_order_user_id, only: [:create]

   def create
    super
   end

  private

  def set_order_user_id
    order = Order.find(cookies.signed[:order_id])
    order.update(user_id: current_user.id)
    cookies.delete :order_id
  end
end
