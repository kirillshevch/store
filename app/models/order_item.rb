class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book
  belongs_to :user
  belongs_to :visitor

  before_save :count_price

  validates :quantity, numericality: true, inclusion: { in: 1..99 }

  def count_price
    self.price = (book.price * quantity).to_i
  end
end
