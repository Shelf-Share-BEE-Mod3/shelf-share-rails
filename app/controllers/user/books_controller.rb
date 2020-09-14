# frozen_string_literal: true

class User::BooksController < ApplicationController
  def index
    @userbooks = UserBook.where(user_id: current_user.id)
  end

  def new; end

  def create
    book = BookFacade.find_by_isbn(params[:isbn])
    user_book = UserBook.new(status: 'available', user_id: current_user.id, isbn: book.isbn)
    if user_book.save
      flash[:success] = "Added to Shelf: #{book.title}, by #{book.author}"
    elsif book.isbn.nil?
      flash[:not_found] = "Oops! That book cannot be found."
    end
    redirect_to new_user_book_path
  end
end
