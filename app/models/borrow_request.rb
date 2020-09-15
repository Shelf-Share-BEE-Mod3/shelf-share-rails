class BorrowRequest < ApplicationRecord
  validates_presence_of :borrower_id, :user_book_id
  validates :status, numericality: { only_integer: true }

  belongs_to :borrower, class_name: :User, foreign_key: :borrower_id
  belongs_to :user_book

  enum status: [:pending, :declined, :accepted, :returned]
end
