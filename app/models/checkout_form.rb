class CheckoutForm

  include Virtus.model
  include ActiveModel::Model

  attribute :delivery, Integer

  attribute :billing_first_name, String
  attribute :billing_last_name, String
  attribute :billing_addr, String
  attribute :billing_zipcode, String
  attribute :billing_city, String
  attribute :billing_phone, String
  attribute :billing_country_id, Integer
  attribute :copyaddress, Boolean

  attribute :shipping_first_name, String
  attribute :shipping_last_name, String
  attribute :shipping_addr, String
  attribute :shipping_zipcode, String
  attribute :shipping_city, String
  attribute :shipping_phone, String
  attribute :shipping_country_id, Integer

  attribute :number, Integer
  attribute :cvv, Integer
  attribute :month, Integer
  attribute :year, Integer

  def initialize(order)
    @order = order

    if @order.billing_address.present?
      self.attributes = { billing_first_name: @order.billing_address.first_name, billing_last_name: @order.billing_address.last_name,
                          billing_addr: @order.billing_address.address, billing_zipcode: @order.billing_address.zipcode,
                          billing_city: @order.billing_address.city, billing_phone: @order.billing_address.phone,
                          billing_country_id: @order.billing_address.country_id }
    end

    if @order.shipping_address.present?
      self.attributes = { shipping_first_name: @order.shipping_address.first_name, shipping_last_name: @order.shipping_address.last_name,
                          shipping_addr: @order.shipping_address.address, shipping_zipcode: @order.shipping_address.zipcode,
                          shipping_city: @order.shipping_address.city, shipping_phone: @order.shipping_address.phone,
                          shipping_country_id: @order.shipping_address.country_id }
    end

    if @order.delivery.present?
      self.attributes = { delivery: @order.delivery }
    end

    if @order.credit_card.present?
      self.attributes = { number: @order.credit_card.number, cvv: @order.credit_card.cvv, month: @order.credit_card.month,
                          year: @order.credit_card.year }
    end
  end

  def billing_address
    if @order.billing_address.present?
      billing_address = @order.billing_address
    else
      billing_address = @order.build_billing_address
    end
    billing_address
  end

  def shipping_address
    if @order.shipping_address.present?
      shipping_address = @order.shipping_address
    else
      shipping_address = @order.build_shipping_address
    end
    shipping_address
  end

  def credit_card
    if @order.credit_card.present?
      credit_card = @order.credit_card
    else
      credit_card = @order.build_credit_card
    end
    credit_card
  end

  def submit(params)
    billing_address.attributes = address_attributes("billing_", params)
    shipping_address.attributes = address_attributes("shipping_", params)
    credit_card.attributes = { number: params[:number], cvv: params[:cvv], month: params[:month], year: params[:year] }
    if params[:copyaddress]
      shipping_address.attributes = address_attributes("billing_", params)
    end
    @order.attributes = { delivery: params[:delivery] }
  end

  def save
    billing_address.save! if billing_address.valid?
    shipping_address.save! if shipping_address.valid?
    credit_card.save! if credit_card.valid?
    @order.save! if @order.valid?
    true
  end

  def persisted?
    false
  end

  private

    def address_attributes(prefix, params)
      { first_name: params[("#{prefix}first_name").to_sym], last_name: params[("#{prefix}last_name").to_sym], address: params[("#{prefix}addr").to_sym],
        zipcode: params[("#{prefix}zipcode").to_sym], city: params[("#{prefix}city").to_sym],
        phone: params[("#{prefix}phone").to_sym], country_id: params[("#{prefix}country_id").to_sym]  }
    end
end