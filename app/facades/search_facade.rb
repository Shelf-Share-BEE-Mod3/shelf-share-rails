class SearchFacade

  def self.search(keyword, id)
    books = Book.search(keyword)
    books.find_friends_available_books(id)
  end
end
