class BillingAddressesController < ApplicationController
  def new
    if current_user
      @billing_address = current_user.billing_address.new
    end
  end

  def create
    if current_user
      current_user.billing_address.create!(address_params)
      redirect_to :back# TODO redirect to delivery if create from checkout
    end
  end

  def edit
  end

  def update
  end

  private

    def address_params
      params.require(:billing_address).require(:first_name, :last_name, :address, :city,
                                               :country_id, :zipcode, :phone)
    end
end
