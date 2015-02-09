class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book
  belongs_to :user
end
