class BooksController < ApplicationController
  def index
    @friends = current_user.friends.includes(:user_books)
  end
end
