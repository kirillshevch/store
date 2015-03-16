class BillingAddressesController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, alert: "Error"
  end

  def create
    address = current_user.build_billing_address(address_params)
    if address.save
      redirect_to :back
    else
      redirect_to :back, alert: "Create billing address error"
    end
  end

  def update
    address = current_user.billing_address
    if address.update(address_params)
      redirect_to :back
    else
      redirect_to :back, alert: "Update billing address error"
    end
  end

  private

  def address_params
    params.require(:billing_address).permit(:first_name, :last_name, :address, :city,
                                            :country_id, :zipcode, :phone)
  end
end
