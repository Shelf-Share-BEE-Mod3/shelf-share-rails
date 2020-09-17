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
      end
    end

    # before :each do
    # end

    xit 'I see a section listing current requests for my books, or a message if no books are being requested' do
      within ".current-requests" do
        expect(page).to have_content("No current requests")
      end

      # Request a book here

      visit user_dashboard_path

      within ".current-requests" do
        expect(page).to have_content("You have #{@user.current_book_requests} book requests") # Create a requests method that counts the number of requests?
        expect(page).to have_content("Books: #{@user.requested_book_titles}") # Do we want the book title to show up as well? How do we grab this information?
      end
    end

    xit 'I see a section listing books I have currently borrowed and their owners' do
      within ".currently-barrowed" do
        expect(page).to have_content("You have #{@user.barrowed_book} barrowed books") # Create a barrowed method?
        expect(page).to have_content("Books: #{@user.barrowed_book_titles}")
        expect(page).to have_content("Book Owner: #{@user.barrowed_book_owners}") # Might be better verbiage to use here?
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

    xit 'I see a section telling me about in transit books' do
      within ".in-transit" do
        expect(page).to have_content("In Transit Books: #{@user.transit_titles}") # Create a transit_titles method?
      end
    end

    xit 'I see a link to Add Friends' do
      expect(page).to have_link("Add Friends")
    end
  end
end
