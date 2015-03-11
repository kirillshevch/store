class Permitted

  def initialize(step)
    @step = step
  end

  def step_permitted
    case @step
      when :billing_address
        [:billing_first_name, :billing_last_name, :billing_addr, :billing_zipcode, :billing_city,
         :billing_phone, :billing_country_id, :copyaddress, :form_step]
      when :shipping_address
        [:shipping_first_name, :shipping_last_name, :shipping_addr, :shipping_zipcode, :shipping_city,
         :shipping_phone, :shipping_country_id]
      when :delivery
        [:delivery]
      when :payment
        [:number, :month, :year, :cvv]
      when :confirm
        [:state]
    end
  end
end