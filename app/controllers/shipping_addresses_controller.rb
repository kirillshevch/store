class ShippingAddressesController < ApplicationController
  def create
    current_user.create_shipping_address(address_params)
    redirect_to :back
  end

  def update
    @address = current_user.shipping_address
    @address.update(address_params)
    redirect_to :back
  end

  private

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
