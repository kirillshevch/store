class BillingAddress < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
end
