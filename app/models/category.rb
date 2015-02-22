class Category < ActiveRecord::Base
  has_many :books
  has_many :authors, through: :books

  validates :name, presence: true,, uniqueness: true, length: { maximum: 50 }
end
