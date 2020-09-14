class BookFacade
  def self.find_by_isbn(isbn)
    response = BookBuddyService.find_by_isbn(isbn)
    book_params = response[:data][:attributes]
    Book.find_or_create_by(isbn: isbn) do |book|
      book.title = book_params[:title]
      book.author = book_params[:author]
      book.description = book_params[:description]
      book.thumbnail = book_params[:thumbnail]
      book.isbn = book_params[:isbn]
      book.category= book_params[:category]
    end
  end
end
