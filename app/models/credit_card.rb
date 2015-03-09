class CreditCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :number, :cvv, :month, :year, presence: true, numericality: true
  validates :number, length: { is: 14 }
  validates :cvv,    length: { is: 3 }
  validates :month,  inclusion: { in: 1..12 }
  validates :year,   inclusion: { in: 2015..2030 }
end
