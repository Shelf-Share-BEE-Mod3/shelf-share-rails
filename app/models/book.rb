class Book < ApplicationRecord
  validates_presence_of :title, :author, :description, :thumbnail, :isbn, :category
  validates_uniqueness_of :isbn

  has_many :user_books
  has_many :users, through: :user_books

  def find_status
    UserBook.find_by(book_id: id).status
  end

  def self.lent_to_user(id)
    joins(user_books: :borrow_requests).where(borrow_requests: { borrower_id: id, status: 2 })
    # BorrowRequest.where(borrower_id: id).where(status: 2)
  end

end
