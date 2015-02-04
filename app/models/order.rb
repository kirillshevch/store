class Order < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  belongs_to :credit_card
end
