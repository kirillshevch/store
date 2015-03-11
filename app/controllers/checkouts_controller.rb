class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps :billing_address, :shipping_address, :delivery, :payment, :confirm

  def show
    access = Access.new(current_order, step)
    if access.step_access?
      @checkout_form = CheckoutForm.new(current_order, step)
      @countries = Country.all
      render_wizard
    else
      redirect_to access.redirect_url, alert: access.error_text
    end
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

    def checkout_form_params
      permitted = Permitted.new(step).step_permitted
      params.require(:checkout_form).permit(permitted)
    end
end
