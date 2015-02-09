class CreditCard < ActiveRecord::Base
  belongs_to :user

  validates :number, :cvv, :month, :year, :user_id, presence: true
end
