class User::DashboardController < ApplicationController
  def show
    @friend_requests = current_user.current_friend_requests
    @book_requests = BorrowRequestFacade.incoming_book_borrow_requests(current_user)
    @borrowed_books = current_user.borrow_requests.find_approved_requests
  end
end
