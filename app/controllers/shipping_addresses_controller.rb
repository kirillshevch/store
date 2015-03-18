class ShippingAddressesController < ApplicationController
  def create
    address = current_user.build_shipping_address(address_params)
    if address.save
      redirect_to :back, notice: t('addresses.success_add_ship')
    else
      redirect_to :back, alert: t('addresses.error_add_ship')
    end
  end

  def update
    address = current_user.shipping_address
    if address.update(address_params)
      redirect_to :back, notice: t('addresses.success_upd_ship')
    else
      redirect_to :back, alert: t('addresses.error_upd_ship')
    end
  end

  private

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
