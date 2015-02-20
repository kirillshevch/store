class CreditCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitor

  validates :number, :cvv, :month, :year, presence: true
end
