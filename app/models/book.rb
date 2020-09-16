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
end
