class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  default_scope { order('id') }

  before_save :count_price

  validates :quantity, numericality: true, inclusion: { in: 1..99 }

  def count_price
    self.price = (book.price * quantity).to_i
  end
end
