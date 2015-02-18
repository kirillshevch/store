class ShippingAddressesController < ApplicationController
  def create
    current_user.shipping_address = ShippingAddress.create!(address_params)
    redirect_to :back# TODO redirect to delivery if create from checkout
  end

  def update
    @address = current_user.shipping_address
    @address.update(address_params)
    redirect_to :back# TODO redirect to delivery if create from checkout
  end

  private

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
