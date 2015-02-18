class BillingAddressesController < ApplicationController
  def create
    current_user.billing_address = BillingAddress.create!(address_params)
    redirect_to :back# TODO redirect to delivery if create from checkout
  end

  def update
    @address = current_user.billing_address
    @address.update(address_params)
    redirect_to :back# TODO redirect to delivery if create from checkout
  end

  private

  def address_params
    params.require(:billing_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
