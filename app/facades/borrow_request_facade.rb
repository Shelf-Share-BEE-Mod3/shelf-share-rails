class BorrowRequestFacade
  def self.incoming_book_borrow_requests(user)
    user.incoming_book_borrow_requests.map do |request|
      params = {
        belongs_to: user.full_name,
        borrower: request.borrower.full_name,
        book_title: request.user_book.book.title
      }
      BorrowRequestPoro.new(params)
    end
  end

end
