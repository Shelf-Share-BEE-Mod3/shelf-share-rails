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
  end

  def self.available
    joins(:user_books).where(user_books: {status: 'available'})
  end

  def self.search(keyword) ##double check SQL that its only doing a single query
    Book.where('title ILIKE ?', "%#{sanitize_sql_like(keyword)}%").
      or(Book.where('isbn ILIKE ?', "%#{sanitize_sql_like(keyword)}%")).
      or(Book.where('author ILIKE ?', "%#{sanitize_sql_like(keyword)}%")).
      or(Book.where('description ILIKE ?', "%#{sanitize_sql_like(keyword)}%"))
  end

  def self.find_friends_available_books(id)
    ids = Friendship.where(user_id: id).pluck(:friend_id)
    joins(:user_books, :users).where(user_books: {user_id: ids, status: 'available'})
  end

  def find_borrower(lender_id)
    userbook = UserBook.where({user_id: lender_id, book_id: self.id, status: 'unavailable'})[0]
    borrow_request = BorrowRequest.where(user_book_id: userbook.id).find_by(status: 2)
    User.find(borrow_request.borrower_id)
  end
end
