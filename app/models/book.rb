class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many   :ratings
  has_many   :users, through: :ratings
end
