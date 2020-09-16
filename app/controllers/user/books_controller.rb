# frozen_string_literal: true

class User::BooksController < ApplicationController
  def index
    @available_books = current_user.available_books
    @unavailable_books = current_user.unavailable_books
  end

  def new; end

  def create
    # if current_user.nil? bounce to 404 page
    book = BookFacade.find_by_isbn(params[:isbn])
    if book.isbn.nil?
      flash[:failure] = "Oops! That book cannot be found."
      redirect_to new_user_book_path and return
    end

    user_book = UserBook.new(status: 'available', user_id: current_user.id, book_id: book.id)
    if user_book.save
      flash[:success] = "Added to Shelf: #{book.title}, by #{book.author}"
      redirect_to user_books_path
    else
      flash[:failure] = "Something happened, try again."
      redirect_to new_user_book_path
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
