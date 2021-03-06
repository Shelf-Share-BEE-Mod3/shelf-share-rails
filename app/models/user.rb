# frozen_string_literal: true

class User < ApplicationRecord
  has_one :address

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friend_requests
  has_many :user_books
  has_many :borrow_requests, foreign_key: :borrower_id
  has_many :books, through: :user_books

  def self.update_or_create(auth)
    User.find_by(uid: auth[:uid]) || new_user(auth)
  end

  def self.new_user(auth)
    user = User.new(new_user_attributes(auth))
    user if user.save!
  end

  def self.new_user_attributes(auth)
    {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      token: auth[:credentials][:token],
      refresh_token: auth[:credentials][:refresh_token],
      oauth_expires_at: auth[:credentials][:expires_at]
    }
  end

  def current_friend_requests
    requests = {}
    friend_requests.where('status = 0').each do |friend|
      requests[friend] = User.find(friend.from)
    end
    requests
  end

  def loaned_books
    books.joins(user_books: :borrow_requests).
      where("user_books.status != 'available'").
      where("borrow_requests.status = 2")
  end

  def available_books
    books.joins(:user_books).where("user_books.status = 'available'")
  end

  def unavailable_books
    books.joins(:user_books).where("user_books.status != 'available'")
  end

  def full_name
    first_name + " " + last_name
  end

  def self.who_owns_this_book(book)
    ids = book.user_books.where(user_id: self.ids).pluck(:user_id)
    self.where(id: ids)
  end

  def incoming_book_borrow_requests
    ids = user_books.joins(:borrow_requests).where(status: 'available').pluck(:id)
    BorrowRequest.where(user_book_id: ids, status: 0).includes(:borrower, user_book: :book)
  end
end
