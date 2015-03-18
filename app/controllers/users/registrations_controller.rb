class Users::RegistrationsController < Devise::RegistrationsController

  after_action :set_order_user_id, only: [:create]

   def create
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
      order = Order.find(cookies.signed[:order_id])
      order.update(user_id: current_user.id)
      cookies.delete :order_id
    end
end
