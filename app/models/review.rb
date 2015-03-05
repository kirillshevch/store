class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :number, :title, :book_id, presence: true
  validates :number, numericality: true, inclusion: { in: 1..10 }
  validates :title, length: { maximum: 100 }
  validates :text, length: { maximum: 500 }
end
