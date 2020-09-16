class StatusFacade

  def self.change_user_book_status_to_available(id)
    user_book = UserBook.find(id)
    user_book.status_change_to_available
    user_book.save
  end

  def self.change_borrow_request_status_to_returned(id)
    borrow_request = BorrowRequest.find(id)
    borrow_request.status_changed_to_returned
    borrow_request.save
  end
end
