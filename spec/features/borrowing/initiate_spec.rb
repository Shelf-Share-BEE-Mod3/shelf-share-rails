require "rails_helper"

RSpec.describe "Borrowing Spec 1/?" do
  before :each do
    @borrower = create(:borrower)
    @librarian = create(:user)
    @address1 = create(:address, user: @borrower, address_second: "Apt 101")
    @address2 = create(:address, user: @librarian, address_second: "Apt 222")
    @borrower.friends << @librarian
    @librarian.friends << @borrower
    @book = create(:book)
    @user_book = create(:user_book, user: @librarian, book: @book)
    # @borrow_request = create(:borrow_request, borrower: @borrower, user_book: @user_book)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@borrower)
    # user 1 is borrowing from user 2
  end
  it "I can send a book borrow request to my friend" do
    # logged in as @borrower
    visit books_path
    click_link @book.title
    expect(current_path).to eq(book_path(@book))

    expect do
      click_button "Ask to Borrow"
    end.to change { BorrowRequest.count }.by(1)
  end
end
