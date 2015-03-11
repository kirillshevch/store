class Access

  include Rails.application.routes.url_helpers

  def initialize(order, step)
    @order, @step = order, step
  end

  def step_access?
    case @step
      when :billing_address
        if @order.order_items.present?
          true
        else
          @error = "Select book before checkout"
          @url = shop_path
          false
        end
      when :shipping_address
        if @order.billing_address.present?
          true
        else
          @error = "Specify the billing address"
          @url = checkout_path(:billing_address)
          false
        end
      when :delivery
        if @order.shipping_address.present?
          true
        else
          @error = "Specify the shipping address"
          @url = checkout_path(:shipping_address)
          false
        end
      when :payment
        if @order.delivery > 0
          true
        else
          @error = "Select a delivery method"
          @url = checkout_path(:delivery)
          false
        end
      when :confirm
        if @order.credit_card.present?
          true
        else
          @error = "Specify the credit card"
          @url = checkout_path(:payment)
          false
        end
      when :wicked_finish
        true
    end
  end

  def error_text
    @error
  end

  def redirect_url
    @url
  end
end