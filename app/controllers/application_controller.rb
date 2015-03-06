class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_order, :current_order

  helper_method :current_order

  def set_order
    if current_user.nil? && !cookies[:order_id]
      new_order = Order.create(state_id: 1)
      cookies[:order_id] = new_order.id
    end
  end
# refactoring this, delete state_id,
  def current_order
    if current_user.nil?
      Order.find_by(id: cookies[:order_id], state_id: 1)
    else
      order = current_user.orders.find_by(state_id: 1)
      if order.nil?
        current_user.orders.create!(state_id: 1)
      else
        order
      end
    end
  end
end
