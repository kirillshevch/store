class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
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
  end


  def count_price
    sum = order_items.map {|item| item.price}.sum + (delivery).to_i
    self.price = sum
  end
end
