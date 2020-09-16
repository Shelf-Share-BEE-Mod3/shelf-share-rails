class ReturnController < ApplicationController

  def index
    @borrow_requests = current_user.borrow_requests.find_approved_requests
  end

  def show
    @friend = User.find(params[:id])
    user_book = UserBook.find(params[:user_book_id])
    user_book.status_change_to_available
    user_book.save
  end
end
