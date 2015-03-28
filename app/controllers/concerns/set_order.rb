module SetOrder
  extend ActiveSupport::Concern

  def set_order_user_id
    order = Order.find(cookies.signed[:order_id])
    order.update(user_id: current_user.id)
    cookies.delete :order_id
  end

  def set_order_in_queue_user_id
    if cookies[:order_id_for_sign_up]
      order = Order.find(cookies.signed[:order_id_for_sign_up])
      order.update(user_id: current_user.id)
      cookies.delete :order_id_for_sign_up
    end
  end
end