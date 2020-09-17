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
  end

  it 'can pass the model assertions for incoming_book_borrow_requests' do
    expect(@book_owner.incoming_book_borrow_requests).to include(@borrow_request1) # pending
    expect(@book_owner.incoming_book_borrow_requests).to_not include(@borrow_request2) # accepted
  end

  describe 'feature' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@book_owner)
    end
    it 'has borrow_request notification on the dashboard' do
      visit user_dashboard_path
      within ".book-requests" do
        expect(page).to have_content("You have 1 new book request")
      end
    end
    it 'can click to borrow_requests on the index page' do
      visit user_dashboard_path
      within ".book-requests" do
        click_on("1 new book request")
      end
      expect(current_path).to eq(borrow_index_path)
    end
    it 'the index only has pending book requests' do
      visit borrow_index_path
      within ".pending-requests" do
        expect(page).to have_content("Incoming Borrow Requests")
        book_request = find(".book-request", match: :first)
        message = "#{@borrow_request1.borrower.full_name} wants to borrow #{@borrow_request1.user_book.book.title}"
        expect(page).to have_content(message)
        expect(page).to_not have_content(@borrow_request2.user_book.book)
        expect(page).to have_button "Approve"
        expect(page).to have_button "Decline"
      end
    end
  end
end
