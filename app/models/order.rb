class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :credit_card, dependent: :destroy
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

    # TODO
    event :checkout do
      transitions from: :in_progress, to: :in_queue
    end
  end

  # TODO
  def checkout

  end

  def count_price
    price = order_items.map {|item| item.price}.sum
    sum = (sum).to_i + (delivery).to_i
    self.price = sum
  end
end
