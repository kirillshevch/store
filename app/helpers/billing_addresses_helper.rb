module BillingAddressesHelper
  def billing_action(id)
    if current_user.billing_address == nil
      billing_addresses_url
    else
      billing_address_url(id)
    end
  end
end
