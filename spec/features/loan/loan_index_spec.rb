require "rails_helper"

RSpec.describe "Borrow Requests Index Page Spec" do
  before :each do
    @borrower = create(:borrower)
    @book_owner = create(:user)

    @borrower.friends << @book_owner
    @book_owner.friends << @borrower
    @book = create(:book)

    #pending request
    @user_book1 = create(:user_book, user: @book_owner, book: @book)
    @borrow_request1 = create(:borrow_request, borrower: @borrower, user_book: @user_book1)

    # accepted request
    @user_book2 = create(:user_book, user: @book_owner, book: @book, status: 'unavailable')
    @borrow_request2 = create(:borrow_request, borrower: @borrower, user_book: @user_book2, status: 2)
    # user1 is asking for a book from book_owner
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@book_owner)
  end
  it 'can access from the dashboard' do
    visit user_dashboard_path

    within ".loaned-books" do
      click_on("1 book")
    end

    expect(current_path).to eq(loan_index_path)
  end
  it 'has loaned books info' do
    visit loan_index_path

    expect(page).to have_content("Books Out On Loan")
    expect(page).to have_content(@book.thumbnail)
    expect(page).to have_content(@borrower.name)
  end
end
