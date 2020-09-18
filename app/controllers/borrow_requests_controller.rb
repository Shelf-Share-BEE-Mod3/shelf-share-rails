class BorrowRequestsController < ApplicationController
  def index
    @incoming_requests = current_user.incoming_book_borrow_requests
    #consider outsourcing to facade. Use BR PORO 
    @outgoing_requests = current_user.borrow_requests.where(status: 'pending').includes(user_book: :book)
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
end
