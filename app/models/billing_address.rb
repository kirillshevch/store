class BillingAddress < ActiveRecord::Base
  belongs_to :country
  belongs_to :user

  validates :first_name, :last_name, :address, :zipcode, :city,
            :phone, :country_id, presence: true
end
