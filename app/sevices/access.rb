class Access

  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TranslationHelper

  def initialize(user, order, step)
    @user, @order, @step = user, order, step
  end

  def step_access?
    case @step
      when :billing_address
        if @order.order_items.present?
          true
        else
          @error = t('access.select_book')
          @url = shop_path
          false
        end
      when :shipping_address
        @form = CheckoutForm.new(@user, @order, :billing_address)
        if @form.valid?
          true
        else
          @error = t('access.bill_error')
          @url = checkout_path(:billing_address)
          false
        end
      when :delivery
        @form = CheckoutForm.new(@user, @order, :shipping_address)
        if @form.valid?
          true
        else
          @error = t('access.ship_error')
          @url = checkout_path(:shipping_address)
          false
        end
      when :payment
        @form = CheckoutForm.new(@user, @order, :delivery)
        if @form.valid?
          true
        else
          @error = t('access.deliv_error')
          @url = checkout_path(:delivery)
          false
        end
      when :confirm
        @form = CheckoutForm.new(@user, @order, :all)
        if @form.valid?
          true
        else
          @error = t('access.pay_error')
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