class BorrowRequestsController < ApplicationController
  def index
    @requests = current_user.incoming_book_borrow_requests
  end

  def show
    borrow_request = BorrowRequest.find(params[:id])
    approve_request(borrow_request)
    @address = Address.includes(:user).find_by(user_id: borrow_request.borrower_id)
  end

  def update
    borrow_request = BorrowRequest.find(params[:id])
    borrow_request.approve_request
    redirect_to address_path(borrow_request.borrower.address)
  end

  def create
    user_book_id = UserBook.find_by(user_id: params[:friend_id], book_id: params[:friend_book_id], status: 'available').id
    a = BorrowRequest.new(status: 0, user_book_id: user_book_id, borrower_id: params[:user_id])
    a.save
  end

  def destroy
    borrow_request = BorrowRequest.find(params[:id])
    borrow_request.update(status: 1)
    decline_message = "You have declined #{borrow_request.borrower.first_name}'s " +
                      "request to borrow #{borrow_request.user_book.book.title}"
    flash[:success] = decline_message
    redirect_to user_dashboard_path
  end
end
