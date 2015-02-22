class User < ActiveRecord::Base
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :reviews
  has_many :orders
  has_one  :credit_card
  has_many :order_items
  has_one  :billing_address
  has_one  :shipping_address

  validates :first_name, length: { maximum: 50 }, numericality: false
  validates :last_name,  length: { maximum: 50 }, numericality: false

  def self.find_for_facebook_oauth access_token
    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook, :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20])
    end
  end
end
