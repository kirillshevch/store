class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book
  belongs_to :user
  belongs_to :visitor

  validates :quantity, numericality: true, inclusion: { in: 1..99 }
end
