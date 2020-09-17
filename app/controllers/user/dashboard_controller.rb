class User::DashboardController < ApplicationController
  def show
    @borrow_requests = BorrowRequestFacade.incoming_book_borrow_requests(current_user)
  end
end
