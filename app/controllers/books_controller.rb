class BooksController < ApplicationController
  def index
    @friends = current_user.friends.includes(:books)
  end

  def show
    @book = Book.find(params[:id])
    @friend = User.find(params[:friend_id])
  end
end
