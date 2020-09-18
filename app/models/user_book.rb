# frozen_string_literal: true

class UserBook < ApplicationRecord
  belongs_to :user
  has_many :borrow_requests
  belongs_to :book

  validates_presence_of :status, :user_id

  def self.find_available_userbooks
    where(status: 'available')
  end

  def self.find_unavailable_userbooks
    where.not(status: 'available')
  end

  def self.userbooks_lent_to_user(id)
    joins(:borrow_requests).where(borrow_requests: { borrower_id: id, status: 2 })
  end

  def find_book_from_userbook
    Book.find(book_id)
  end

  def status_change_to_available
    self.status = "available"
  end

  def change_status
    if self.status == "available"
      self.status = 'unavailable'
    else
      self.status = 'available'
    end
  end
end
