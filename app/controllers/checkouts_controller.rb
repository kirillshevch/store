class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps *CheckoutForm.form_steps
  #service objects
  def show
    @checkout_form = CheckoutForm.new(current_order)
    @countries = Country.all
    render_wizard
  end

  def update
    @checkout_form = CheckoutForm.new(current_order)
    @countries = Country.all
    if @checkout_form.submit(checkout_form_params)
      if checkout_form_params[:copyaddress]
        jump_to(:delivery)
      end
      render_wizard(@checkout_form)
    end
  end

  private

    def permitted
      case step
        when :billing_address
          [:billing_first_name, :billing_last_name, :billing_addr, :billing_zipcode, :billing_city,
           :billing_phone, :billing_country_id, :copyaddress]
        when :shipping_address
          [:shipping_first_name, :shipping_last_name, :shipping_addr, :shipping_zipcode, :shipping_city,
           :shipping_phone, :shipping_country_id]
        when :delivery
          [:delivery]
        when :payment
          [:number, :month, :year, :cvv]
      end
    end

    def checkout_form_params
      params.require(:checkout_form).permit(permitted)
    end
end
