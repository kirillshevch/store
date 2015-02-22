class CreditCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitor

  validates :number, :cvv, :month, :year, presence: true, numericality: true
  validates :cvv,   length: { is: 3 }
  validates :month, inclusion: 1..12
  validates :year,  inclusion: 2015..2030
end
