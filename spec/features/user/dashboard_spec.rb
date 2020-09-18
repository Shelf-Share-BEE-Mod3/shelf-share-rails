require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'When I visit my dashboard' do

    it 'I see a section telling me about any new friend requests' do
      user = create(:user)

      create_list(:friend, 5).each do |friend|
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(friend)
        visit user_friends_path
        fill_in :email, with: user.email
        click_on 'Add Friend'
      end

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit user_dashboard_path
      within ".friend-requests" do
        expect(page).to have_content("You have 5 new friend requests")
        expect(page).to have_link("5 new friend requests", href: user_friends_path)
      end
    end

    it 'I see a section listing current requests for my books, or a message if no books are being requested' do
      user1, user2 = create_list(:user, 2)
      user1.friends << user2
      user2.friends << user1
      book = create(:book)
      user_book1 = create(:user_book, user: user2, book: book)
      user_book2 = create(:user_book, user: user2, book: book, status: 'unavailable')
      borrow_request1 = create(:borrow_request, borrower: user1, user_book: user_book1)
      borrow_request2 = create(:borrow_request, borrower: user1, user_book: user_book2, status: 1)
      # user1 wants to borrow from user2

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      visit user_dashboard_path
      within ".book-requests" do
        expect(page).to have_content("You have 1 new book request")
        expect(page).to have_link("1 new book request", href: borrow_index_path)
        expect(page).to_not have_content("No current requests")
      end
    end

    it 'I see a section listing books I have currently borrowed and their owners' do
      user1, user2 = create_list(:user, 2)
      user1.friends << user2
      user2.friends << user1
      book = create(:book)
      user_book1 = create(:user_book, user: user2, book: book)
      borrow_request1 = create(:borrow_request, borrower: user1, user_book: user_book1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      visit user_dashboard_path
      expect(page).to_not have_content("No current requests")

      user_book2 = create(:user_book, user: user1, book: book, status: 'unavailable')
      borrow_request2 = create(:borrow_request, borrower: user2, user_book: user_book2, status: 2)
      visit user_dashboard_path

      within ".borrowed-books" do
        expect(page).to have_content("You are borrowing 1 book")
        expect(page).to have_link("1 book", href: return_index_path)
        expect(page).to_not have_content("No current requests")
      end
    end

    xit 'I see a section listing the books I have currently lent out and to whom' do
      within ".lent-out" do
        expect(page).to have_content("You have #{@user.lent_books} books lent out") # Create a lent_books method?
        expect(page).to have_content("Books: #{@user.lent_book_titles}")
        expect(page).to have_content("Lent To: #{@user.lent_book_to}")
      end
    end

    xit 'I see a section listing a random sample of book recommendations' do
      within ".book-recommendations" do
        expect(page).to have_css() # We are grabbing the recommended book covers and displaying them here.
      end
    end

  end
end
