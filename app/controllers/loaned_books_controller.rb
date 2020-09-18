class LoanedBooksController < ApplicationController
  def index
    @loaned_books = current_user.loaned_books
  end
end
