class User < ActiveRecord::Base
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :ratings
  has_many :books, through: :ratings
  has_many :orders
  has_many :credit_cards

  validates :password,   presence: true
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
