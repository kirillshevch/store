class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_visitor, :current_order

  helper_method :current_order

  def current_user
    cookies[:visitor_id] ? Visitor.find(cookies[:visitor_id]) : super
  end

  def set_visitor
    if !current_user.respond_to?(:email) && !cookies[:visitor_id]
      new_visitor = Visitor.create
      cookies[:visitor_id] = new_visitor.id
    end
  end

  def current_order
    order = current_user.orders.find_by(state_id: 1)
    if order.nil?
      current_user.orders.create!(state_id: 1)
    else
      order
    end
  end
end
