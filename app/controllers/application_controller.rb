class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_order, :current_order, :set_locale

  helper_method :current_order

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

  private

    def set_order
      if current_user.nil? && !cookies[:order_id]
        new_order = Order.create
        cookies.signed[:order_id] = new_order.id
        cookies[:order_for_sign_up] = cookies[:order_id]
        new_order.update(secret_key: cookies[:order_id])
      end
    end

    def set_locale
      if params[:locale].blank?
        I18n.locale = :'en'
      else
        I18n.locale = params[:locale]
      end
    end

    def default_url_options(options = {})
      {:locale => I18n.locale}
    end
end
