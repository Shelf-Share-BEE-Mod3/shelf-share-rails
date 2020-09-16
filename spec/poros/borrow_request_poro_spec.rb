require 'rails_helper'

RSpec.describe BorrowRequestPoro, type: :model do
  before :each do
    @book_owner = create(:user)
    @book_borrower = create(:borrower)
    @book = create(:book)
    @user_book = create(:user_book, book: @book, user: @book_owner)
    @borrow_request = create(:borrow_request, user_book: @user_book, borrower: @book_borrower)

    @params = {
      belongs_to: @book_owner.full_name,
      borrower: @book_borrower.full_name,
      book_title: @book.title
    }

    @book_request = BorrowRequestPoro.new(@params)
  end

  it 'exists' do
    expect(@book_request).to be_instance_of(BorrowRequestPoro)
  end

  it 'has_attributes' do
    expect(@book_request.book_title).to eq(@book.title)
    expect(@book_request.belongs_to).to eq(@book_owner.full_name)
    expect(@book_request.borrower).to eq(@book_borrower.full_name)
  end
end
