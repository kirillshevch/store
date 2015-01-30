class Author < ActiveRecord::Base
  has_many :books
  has_many :categories, through: :books
end
