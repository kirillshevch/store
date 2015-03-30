class BillingAddressesController < ApplicationController
  before_action :load_user
  load_and_authorize_resource through: :user, singleton: true

  def create
    if @billing_address.save
      redirect_to edit_user_registration_url, notice: t('addresses.success_add_bill')
    else
      redirect_to edit_user_registration_url, alert: t('addresses.error_add_bill')
    end
  end

  def update
    if @billing_address.update(billing_address_params)
      redirect_to edit_user_registration_url, notice: t('addresses.success_upd_bill')
    else
      redirect_to edit_user_registration_url, alert: t('addresses.error_upd_bill')
    end
  end

  private

  def billing_address_params
    params.require(:billing_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
