class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_order, :current_order

  helper_method :current_order

  def set_order
    if current_user.nil? && !cookies[:order_id]
      new_order = Order.create
      cookies.signed[:order_id] = new_order.id
      new_order.update(secret_key: cookies[:order_id])
    end
  end

  def current_order
    if current_user.nil?
      Order.find_by(secret_key: cookies[:order_id], state: :in_progress)
    else
      order = current_user.orders.find_by(state: :in_progress)
      if order.nil?
        current_user.orders.create
      else
        order
      end
    end
  end
end
