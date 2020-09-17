class BorrowRequestsController < ApplicationController
  def index
    @incoming_requests = current_user.incoming_book_borrow_requests
    @outgoing_requests = current_user.borrow_requests.where(status: 'pending')
  end

  def show
    borrow_request = BorrowRequest.find(params[:id])
    approve_request(borrow_request)
    @address = Address.includes(:user).find_by(user_id: borrow_request.borrower_id)
  end

  def update
    begin
      borrow_request = BorrowRequest.find(params[:id])
      borrow_request.approve_request
      redirect_to address_path(borrow_request.borrower.address)
    rescue ActionController::UrlGenerationError
      handle_exception(borrow_request)
    end
  end

  def create
    user_book_id = UserBook.find_by(user_id: params[:friend_id], book_id: params[:friend_book_id], status: 'available').id
    borrow_request = BorrowRequest.new(status: 0, user_book_id: user_book_id, borrower_id: params[:user_id])
    borrow_request.save
    redirect_to borrow_index_path
  end

  def destroy
    borrow_request = BorrowRequest.find(params[:id])
    borrow_request.update(status: 1)
    decline_message = "You have declined #{borrow_request.borrower.first_name}'s " +
                      "request to borrow #{borrow_request.user_book.book.title}"
    flash[:success] = decline_message
    redirect_to user_dashboard_path
  end

  private

  def handle_exception(borrow_request)
    borrow_request.update(status: 1)
    borrow_request = BorrowRequestFacade.convert_to_poro(borrow_request)
    error_message = "Oops! #{borrow_request.borrower} somehow made a request" +
                    " without submitting an address. \nThis request has been" +
                    " declined and #{borrow_request.book_title} is still available for borrowing."
    flash[:error] = error_message
    redirect_to user_dashboard_path
  end
end
