class ShippingAddressesController < ApplicationController
  before_action :load_user
  load_and_authorize_resource through: :user, singleton: true

  def create
    if @shipping_address.save
      redirect_to edit_user_registration_url, notice: t('addresses.success_add_ship')
    else
      redirect_to edit_user_registration_url, alert: t('addresses.error_add_ship')
    end
  end

  def update
    if @shipping_address.update(shipping_address_params)
      redirect_to edit_user_registration_url, notice: t('addresses.success_upd_ship')
    else
      redirect_to edit_user_registration_url, alert: t('addresses.error_upd_ship')
    end
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
