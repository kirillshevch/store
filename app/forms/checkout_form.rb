class CheckoutForm

  include Virtus.model
  include ActiveModel::Model

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

  attribute :delivery, Integer
  attribute :state, String

  validates :billing_first_name, :billing_last_name, :billing_address, :billing_zipcode, :billing_city,
            :billing_phone, :billing_country_id, presence: true, if: -> { step_checker(@step, :billing_address) }
  validates :billing_first_name, :billing_last_name, :billing_city, length: { maximum: 50 }, if: -> { step_checker(@step, :billing_address) }
  validates :billing_address, length: { maximum: 100 }, if: -> { step_checker(@step, :billing_address) }
  validates :billing_zipcode, length: { maximum: 20 }, if: -> { step_checker(@step, :billing_address) }

  validates :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_zipcode, :shipping_city,
            :shipping_phone, :shipping_country_id, presence: true, if: -> { step_checker(@step, :shipping_address) }
  validates :shipping_first_name, :shipping_last_name, :shipping_city, length: { maximum: 50 }, if: -> { step_checker(@step, :shipping_address) }
  validates :shipping_address, length: { maximum: 100 }, if: -> { step_checker(@step, :shipping_address) }
  validates :shipping_zipcode, length: { maximum: 20 }, if: -> { step_checker(@step, :shipping_address) }

  validates :number, :cvv, :month, :year, presence: true, numericality: true, if: -> { step_checker(@step, :payment) }
  validates :number, length: { is: 14 }, if: -> { step_checker(@step, :payment) }
  validates :cvv,    length: { is: 3 }, if: -> { step_checker(@step, :payment) }
  validates :month,  inclusion: { in: 1..12 }, if: -> { step_checker(@step, :payment) }
  validates :year,   inclusion: { in: 2015..2030 }, if: -> { step_checker(@step, :payment) }

  validates :delivery, presence: true, if: -> { step_checker(@step, :delivery) }
  validates :delivery, inclusion: { in: 5..15 }, if: -> { step_checker(@step, :delivery) }

  def initialize(user, order, step)
    @user, @order, @step = user, order, step
    if @order.billing_address.present?
      self.attributes = { billing_first_name: @order.billing_address.first_name, billing_last_name: @order.billing_address.last_name,
                          billing_addr: @order.billing_address.address, billing_zipcode: @order.billing_address.zipcode,
                          billing_city: @order.billing_address.city, billing_phone: @order.billing_address.phone,
                          billing_country_id: @order.billing_address.country_id }
    elsif @user
      unless @user.billing_address.nil?
        self.attributes = { billing_first_name: @user.billing_address.first_name, billing_last_name: @user.billing_address.last_name,
                            billing_addr: @user.billing_address.address, billing_zipcode: @user.billing_address.zipcode,
                            billing_city: @user.billing_address.city, billing_phone: @user.billing_address.phone,
                            billing_country_id: @user.billing_address.country_id }
      end
    end


    if @order.shipping_address.present?
      self.attributes = { shipping_first_name: @order.shipping_address.first_name, shipping_last_name: @order.shipping_address.last_name,
                          shipping_addr: @order.shipping_address.address, shipping_zipcode: @order.shipping_address.zipcode,
                          shipping_city: @order.shipping_address.city, shipping_phone: @order.shipping_address.phone,
                          shipping_country_id: @order.shipping_address.country_id }
    elsif @user
      unless @user.shipping_address.nil?
        self.attributes = { shipping_first_name: @user.shipping_address.first_name, shipping_last_name: @user.shipping_address.last_name,
                            shipping_addr: @user.shipping_address.address, shipping_zipcode: @user.shipping_address.zipcode,
                            shipping_city: @user.shipping_address.city, shipping_phone: @user.shipping_address.phone,
                            shipping_country_id: @user.shipping_address.country_id }
      end
    end

    if @order.delivery.present?
      self.attributes = { delivery: @order.delivery }
    end

    unless @order.credit_card.nil?
      self.attributes = { number: @order.credit_card.number, cvv: @order.credit_card.cvv, month: @order.credit_card.month,
                          year: @order.credit_card.year }
    end
  end

  def billing_address
    if @order.billing_address.present?
      @order.billing_address
    else
      @order.build_billing_address
    end
  end

  def shipping_address
    if @order.shipping_address.present?
      @order.shipping_address
    else
      @order.build_shipping_address
    end
  end

  def credit_card
    if @order.credit_card.present?
      @order.credit_card
    else
      @order.build_credit_card
    end
  end

  def submit(params)
    billing_address.attributes = address_attributes("billing_", params)
    shipping_address.attributes = address_attributes("shipping_", params)
    credit_card.attributes = { number: params[:number], cvv: params[:cvv], month: params[:month], year: params[:year] }
    if params[:copyaddress]
      shipping_address.attributes = address_attributes("billing_", params)
    end
    if params[:delivery]
      @order.attributes = { delivery: params[:delivery] }
    end
    self.attributes = params
  end

  def save
    if valid?
      if (@step == :billing_address) || (@step == :shipping_address)
        billing_address.save! if billing_address.valid?
        shipping_address.save! if shipping_address.valid?
      elsif @step == :set_credit
        credit_card.save! if credit_card.valid?
      end
      @order.save! if @order.valid?
      true
    else
      false
    end
  end

  def checkout_complete
    @step = :all
    if valid?
      @order.checkout
    end
  end

  def step_checker(step, valid_step)
    (step == valid_step) || (step == :all)
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