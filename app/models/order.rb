class Order < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  belongs_to :credit_card
  has_one    :billing_address
  has_one    :shipping_address
  belongs_to :visitor
  has_many   :order_items, dependent: :destroy

  validates :state_id, presence: true

end
