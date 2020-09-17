class BorrowRequest < ApplicationRecord
  validates_presence_of :borrower_id, :user_book_id

  belongs_to :borrower, class_name: :User, foreign_key: :borrower_id
  belongs_to :user_book

  enum status: [:pending, :declined, :accepted, :returned]

  def self.find_approved_requests
    where(status: 2)
  end

  def status_changed_to_returned
    self.status = 3
  end

  def approve_request
    self.update(status: 2)
    self.save
    user_book.update(status: 'unavailable')
    user_book.save
  end
end
