class User::DashboardController < ApplicationController
  def show
    # @friend_requests = current_user.current_friend_requests
    @friend_requests = BorrowRequestFacade.find_current_friend_requests(current_user)
    @book_requests = BorrowRequestFacade.incoming_book_borrow_requests(current_user)

    @borrowed_books = current_user.borrow_requests.find_approved_requests
    @loaned_books = current_user.loaned_books
  end
end
