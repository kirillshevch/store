class Author < ActiveRecord::Base
  has_many :books
  has_many :categories, through: :books

  validates  :first_name, :last_name, presence: true, length: { maximum: 30 }
  validates  :description, length: { maximum: 500 }
end
