class ShippingAddressesController < ApplicationController

  def new
    if current_order.shipping_address.nil?
      if current_user.shipping_address.nil?
        @shipping_address = current_order.build_shipping_address
        @countries = Country.all
      else
        redirect_to edit_shipping_address_url(current_user.shipping_address.id)
      end
    else
      redirect_to edit_shipping_address_url(current_order.shipping_address.id)
    end
  end

  def create
    if params[:from_checkout]
      address = current_order.build_shipping_address(address_params)
    else
      address = current_user.build_shipping_address(address_params)
    end

    if address.save
      from_checkout
    else
      redirect_to :back, alert: "Create shipping address error"
    end
  end

  def edit
    @shipping_address = current_order.shipping_address
    @countries = Country.all
  end

  def update
    address = current_user.shipping_address
    if address.update(address_params)
      from_checkout
    else
      redirect_to :back, alert: "Update shipping address error"
    end
  end

  private

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end

  def from_checkout
    if params[:from_checkout]
      redirect_to delivery_url
    else
      redirect_to :back
    end
  end
end
