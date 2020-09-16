class BorrowRequestsController < ApplicationController
  def show

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
end
