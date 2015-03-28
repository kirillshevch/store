class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :coupon
  has_one    :credit_card, dependent: :destroy
  has_one    :billing_address, dependent: :destroy
  has_one    :shipping_address, dependent: :destroy
  has_many   :order_items, dependent: :destroy

  before_update :count_price

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :checkout do
      transitions from: :in_progress, to: :in_queue
    end

    event :send_order do
      transitions from: :in_queue, to: :in_delivery
    end

    event :cancel do
      transitions from: :in_queue, to: :canceled
    end

    event :complete, before: :set_completed_date do
      transitions from: :in_delivery, to: :delivered
    end
  end

  rails_admin do
    list do
      include_all_fields
      field :state, :state
    end
    edit do
      include_all_fields
      # field :state, :state
    end
  end

  def count_price
    if self.coupon
      sum = order_items.map {|item| item.price}.sum + self.delivery - self.coupon.discount
    else
      sum = order_items.map {|item| item.price}.sum + self.delivery
    end
    self.price = sum
  end

  private

    def set_completed_date
      self.completed_date = Date.today
    end
end
