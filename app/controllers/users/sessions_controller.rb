class Users::SessionsController < Devise::SessionsController

  after_action :set_order_user_id, only: [:create]

   def create
    super
   end

  private

  def set_order_user_id
    if cookies[:order_for_sign_up]
      order = Order.find_by(secret_key: cookies[:order_for_sign_up])
      order.update(user_id: current_user.id)
      cookies.delete :order_for_sign_up
      cookies.delete :order_id
    end
  end
end
