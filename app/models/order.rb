class Order < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  belongs_to :credit_card
  belongs_to :billing_address
  belongs_to :shipping_address
  has_many   :order_items, dependent: :destroy

end
