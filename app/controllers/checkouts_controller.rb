class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps :billing_address, :shipping_address, :delivery, :payment, :confirm

  def show
    access = Access.new(current_user, current_order, step)
    if access.step_access? || (params[:id] == "wicked_finish")
      @checkout_form = CheckoutForm.new(current_user, current_order, step)
      render_wizard
    else
      redirect_to access.redirect_url, alert: access.error_text
    end
  end

  def update
    @checkout_form = CheckoutForm.new(current_user, current_order, step)
    if @checkout_form.submit(checkout_form_params)
      if checkout_form_params[:copyaddress]
        jump_to(:delivery)
      end
      if step == :confirm
        cookies.delete :order_id
        @checkout_form.checkout_complete
      end
      render_wizard(@checkout_form)
    end
  end

  private

    def finish_wizard_path
      if current_user
        order = current_user.orders.order('id DESC').find_by(state: :in_queue)
        order_url(order)
      else
        flash[:notice] = t('checkout.sign_up_view_order')
        new_user_registration_url
      end
    end

    def checkout_form_params
      permitted = Permitted.new(step).step_permitted
      params.require(:checkout_form).permit(permitted)
    end
end