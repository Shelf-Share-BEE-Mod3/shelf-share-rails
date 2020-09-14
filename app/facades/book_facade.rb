class BookFacade
  def self.find_by_isbn(isbn)
    book_params = BookBuddyService.find_by_isbn(isbn)
    book = Book.new(book_params)
  end
end
