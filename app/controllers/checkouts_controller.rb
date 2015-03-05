class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps :address, :shipping_address, :delivery, :payment, :confirm, :complete

  def show
    case
      when :address
        render_wizard
      when :shipping_address

      when :delivery
        if current_order.billing_address.nil? || current_order.shipping_address.nil?
          redirect_to checkout_path(:address), alert: "sdfdfds"
        else
          render_wizard
        end
      when :payment
        if current_order.credit_card.nil?
          redirect_to checkout_path(:address), alert: "sdfdfds"
        else
          render_wizard
        end
      when :confirm

      when :complete

    end



  end

  def update

  end
end
