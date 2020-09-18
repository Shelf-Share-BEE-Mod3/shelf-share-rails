class BorrowRequestFacade
  def self.incoming_book_borrow_requests(user)
    user.incoming_book_borrow_requests.map do |request|
      params = {
        id: request.id,
        belongs_to: user.full_name,
        borrower: request.borrower.full_name,
        book_title: request.user_book.book.title
      }
      BorrowRequestPoro.new(params)
    end
  end

  def self.find_current_friend_requests(current_user)
    requests = current_user.current_friend_requests
    requests.map do |request, friend|
      OpenStruct.new(
        request: request,
        friend: friend
      )
    end
  end

  def self.convert_to_poro(borrow_request)
    params = {
      id: borrow_request.id,
      belongs_to: borrow_request.user_book.user.full_name,
      borrower: borrow_request.borrower.full_name,
      book_title: borrow_request.user_book.book.title
    }
    BorrowRequestPoro.new(params)
  end
end
