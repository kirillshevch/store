module ShippingAdressesHelper
  def shipping_action(id)
    if current_user.shipping_address == nil
      shipping_addresses_url
    else
      shipping_address_url(id)
    end
  end
end
