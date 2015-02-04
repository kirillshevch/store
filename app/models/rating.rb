class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :number, :user_id, :book_id, presence: true
  validates :number, numericality: true
  validates_inclusion_of :number, in: 1..10
end
