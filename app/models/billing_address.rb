class BillingAddress < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
  belongs_to :visitor
  belongs_to :order

  validates :first_name, :last_name, :address, :zipcode, :city,
            :phone, :country_id, presence: true
  validates :first_name, :last_name, :city, length: { maximum: 50 }
  validates :address, length: { maximum: 100 }
  validates :zipcode, length: { maximum: 20 }
end
