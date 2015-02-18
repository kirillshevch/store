class Visitor < ActiveRecord::Base
  has_many :orders
  has_many :credit_cards
  has_many :order_items
  has_one  :billing_address
  has_one  :shipping_address


end
