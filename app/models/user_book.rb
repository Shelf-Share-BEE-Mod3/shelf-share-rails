# frozen_string_literal: true

class UserBook < ApplicationRecord
  belongs_to :user
  has_many :borrow_requests

  validates_presence_of :status, :user_id, :isbn

  def self.find_available_userbooks
    where(status: 'available')
  end

  def self.find_unavailable_userbooks
    where.not(status: 'available')
  end

  def self.convert_available_userbooks_to_books(id)
    userbooks = UserBook.where(user_id: id).where(status: 'available')
    userbooks.map do |userbook|
      Book.find_by(isbn: userbook.isbn)
    end
  end

  def self.convert_unavailable_userbooks_to_books(id)
    userbooks = UserBook.where(user_id: id).where(status: 'unavailable')
    userbooks.map do |userbook|
      Book.find_by(isbn: userbook.isbn)
    end
  end
end
