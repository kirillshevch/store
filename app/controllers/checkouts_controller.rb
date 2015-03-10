class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps :billing_address, :shipping_address, :delivery, :payment, :confirm
  #service objects
  def show
    @checkout_form = CheckoutForm.new(current_order, step)
    @countries = Country.all
    render_wizard
  end

  def update
    @checkout_form = CheckoutForm.new(current_order, step)
    @countries = Country.all
    if @checkout_form.submit(checkout_form_params)
      if checkout_form_params[:copyaddress]
        jump_to(:delivery)
      end
      if checkout_form_params[:state]
        cookies.delete :order_id
        @checkout_form.checkout_complete
      end
      render_wizard(@checkout_form)
    end
  end

  private

    def permitted
      case step
        when :billing_address
          [:billing_first_name, :billing_last_name, :billing_addr, :billing_zipcode, :billing_city,
           :billing_phone, :billing_country_id, :copyaddress, :form_step]
        when :shipping_address
          [:shipping_first_name, :shipping_last_name, :shipping_addr, :shipping_zipcode, :shipping_city,
           :shipping_phone, :shipping_country_id]
        when :delivery
          [:delivery]
        when :payment
          [:number, :month, :year, :cvv]
        when :confirm
          [:state]
      end
    end

    def checkout_form_params
      params.require(:checkout_form).permit(permitted)
    end
end
