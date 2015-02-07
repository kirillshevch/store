class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many   :ratings
  has_many   :users, through: :ratings

  validates :title, :short_description, :full_description, :price,
            presence: true

  validates :title,             length: { maximum: 50 }
  validates :short_description, length: { maximum: 150 }
  validates :full_description,  length: { maximum: 500 }

  validates :price, numericality: true

  def self.best_sellers
    Book.where(best_seller: true)
  end
end
