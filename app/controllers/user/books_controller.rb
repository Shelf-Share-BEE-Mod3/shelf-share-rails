class User::BooksController < ApplicationController
  def index
    @userbooks = UserBook.where(user_id: current_user.id)
  end
end