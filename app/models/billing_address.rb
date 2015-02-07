class BillingAddress < ActiveRecord::Base
  belongs_to :country
  belongs_to :user

  validates :address, :zipcode, :city, :phone, :country_id, presence: true
end
