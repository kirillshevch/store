class BillingAddressesController < ApplicationController
  load_and_authorize_resource

  def create
    address = current_user.build_billing_address(billing_address_params)
    if address.save
      redirect_to :back, notice: t('addresses.success_add_bill')
    else
      redirect_to :back, alert: t('addresses.error_add_bill')
    end
  end

  def update
    address = current_user.billing_address
    if address.update(billing_address_params)
      redirect_to :back, notice: t('addresses.success_upd_bill')
    else
      redirect_to :back, alert: t('addresses.error_upd_bill')
    end
  end

  private

  def billing_address_params
    params.require(:billing_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
