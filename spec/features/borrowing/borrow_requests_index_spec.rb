require "rails_helper"

RSpec.describe "Borrow Requests Index Page Spec" do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @user1.friends << @user2
    @user2.friends << @user1
    @book = create(:book)
    @user_book1 = create(:user_book, user: @user2, book: @book)
    @user_book2 = create(:user_book, user: @user2, book: @book, status: 'unavailable')
    @borrow_request1 = create(:borrow_request, borrower: @user1, user_book: @user_book1)
    @borrow_request2 = create(:borrow_request, borrower: @user1, user_book: @user_book2, status: 2)
    # user1 is asking for a book from user2
  end

  it 'can pass the model assertions for incoming_book_borrow_requests' do
    expect(@user2.incoming_book_borrow_requests).to include(@borrow_request1)
    expect(@user2.incoming_book_borrow_requests).to_not include(@borrow_request2)
  end

  describe 'feature' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
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
      end
    end
  end
end
