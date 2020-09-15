class UserbookFacade
  def self.convert_available_userbooks_to_books(id)
    userbooks = UserBook.where(user_id: id)
    userbooks.map do |userbook|
      Book.find_by(isbn: userbook.isbn)
    end
  end

  def self.convert_unavailable_userbooks_to_books

  end
end
