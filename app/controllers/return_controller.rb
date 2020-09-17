class ReturnController < ApplicationController

  def index
    @borrow_requests = current_user.borrow_requests.find_approved_requests
  end

  def show
    @friend = User.find(params[:id])
    @user_book = UserBook.find(params[:user_book_id])
    StatusFacade.change_user_book_status_to_available(params[:user_book_id])
    StatusFacade.change_borrow_request_status_to_returned(params[:borrow_request_id])
  end
end
