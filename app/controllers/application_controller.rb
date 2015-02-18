class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user, :current_visitor

  def current_user
    if cookies[:visitor_id]
      Visitor.find(cookies[:visitor_id])
    else
      super
    end
  end

  def current_visitor
    if !current_user.respond_to?(:email) && !cookies[:visitor_id]
      new_visitor = Visitor.create
      cookies[:visitor_id] = new_visitor.id
    end
  end
end
