class Order < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  belongs_to :credit_card, dependent: :destroy
  has_one    :billing_address, dependent: :destroy
  has_one    :shipping_address, dependent: :destroy
  has_many   :order_items, dependent: :destroy

  validates :state_id, presence: true

  before_update :count_price

  def count_price
    price = order_items.map {|item| item.price}.sum
    sum = (sum + delivery).to_i
    self.price = sum
  end
end
