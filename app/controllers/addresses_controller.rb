class AddressesController < ApplicationController

  before_action :check_order

  def new
    if current_order.billing_address.nil?
      if current_user.billing_address.nil?
        @billing_address = current_order.build_billing_address
        @countries = Country.all
      else
        redirect_to edit_address_url(current_user.billing_address.id)
      end
    else
      redirect_to edit_address_url(current_order.billing_address.id)
    end
  end

  def edit
    @billing_address = current_order.billing_address
    @countries = Country.all
  end

  def create
    if current_order.billing_address.nil?
      address = current_order.build_billing_address(address_params)
      if address.save
        if current_user.billing_address.nil?
          current_user.billing_address.create(address_params)
        end
        copy_address(address_params)
        redirect_to delivery_url
      else
        redirect_to :back, alert: "Save address error"
      end
    end
  end

  def update
    address = current_order.billing_address
    if address.update(address_params)
      copy_address(address_params)
      redirect_to delivery_url
    else
      redirect_to :back, alert: "Address update error"
    end
  end

  private

    def check_order
      if current_order.order_items.count <= 0
        redirect_to shop_url, alert: "Select books before checkout."
      end
    end

    def address_params
      params.require(:billing_address).permit(:first_name, :last_name, :address, :city,
                                              :country_id, :zipcode, :phone)
    end

    def copy_address(address_params)
      if params[:copyaddress]
        if current_user.shipping_address.nil?
          current_user.shipping_address.create(address_params)
        end
        current_order.create_shipping_address(address_params)
      end
    end
end