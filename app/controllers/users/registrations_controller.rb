class Users::RegistrationsController < Devise::RegistrationsController

  after_action :set_order_user_id, only: [:create]

   def create
     flash[:success] = "Authentication success!"
     super
   end

   def edit
     if current_user.billing_address.nil?
       @billing_address = current_user.build_billing_address
     else
       @billing_address = current_user.billing_address
     end

     if current_user.shipping_address.nil?
       @shipping_address = current_user.build_shipping_address
     else
       @shipping_address = current_user.shipping_address
     end
   end

  private

    def set_order_user_id
      if cookies[:order_for_sign_up]
        # TODO DRY
        order = Order.find_by(secret_key: cookies[:order_for_sign_up])
        order.update(user_id: current_user.id)
        cookies.delete :order_for_sign_up
      end
    end
end
