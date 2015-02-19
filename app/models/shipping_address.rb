class ShippingAddress < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
  belongs_to :visitor
  belongs_to :order

  validates :first_name, :last_name, :address, :zipcode, :city,
            :phone, :country_id, presence: true
end