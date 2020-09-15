class BooksController < ApplicationController
  def index
    @friends = current_user.friends.includes(:books)
  end
end
