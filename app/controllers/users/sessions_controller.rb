class Users::SessionsController < Devise::SessionsController
  include SetOrder

  after_action :set_order_in_queue_user_id, only: [:create]

   def create
    super
   end

end
