class AddressesController < ApplicationController

  before_action :check_order

  def index
    if current_order.billing_address == nil
      if current_user.billing_address == nil
        @billing_address = current_order.build_billing_address
      else
        @billing_address = current_user.billing_address
      end
    else
      @billing_address = current_order.billing_address
    end
    @countries = Country.all
  end

  def create
    current_order.create_billing_address(address_params)
    copy_address(address_params)
    redirect_to delivery_url
  end

  private

    def check_order
      if current_order.order_items.count <= 0
        redirect_to shop_url, notice: "Select paying before checkout."
      end
    end

    def address_params
      params.require(:billing_address).permit(:first_name, :last_name, :address, :city,
                                              :country_id, :zipcode, :phone)
    end

    def copy_address(address_params)
      if params[:copyaddress]
        current_order.create_shipping_address(address_params)
      end
    end
end
