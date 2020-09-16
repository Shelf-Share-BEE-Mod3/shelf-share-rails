class BorrowRequestsController < ApplicationController
  def show
    borrow_request = BorrowRequest.find(params[:id])
    approve_request(borrow_request)
    @address = Address.includes(:user).find_by(user_id: borrow_request.borrower_id)
  end

  def create
    friend_book = UserBook.where(user_id: params[:friend_id], book_id: params[:friend_book_id]).first
    if friend_book.status == 'available'
      BorrowRequest.create(status: 0, user_book: friend_book, borrower_id: params[:user_id])
      friend_book.update(status: 'unavailable')
      flash[:success] = "Borrow Request sent to #{User.find(params[:friend_id]).full_name}"
      redirect_to books_path
    end
  end

  def approve_request(request)
    request.user_book.update(status: 'unavailable')
    request.accepted!
  end
end
