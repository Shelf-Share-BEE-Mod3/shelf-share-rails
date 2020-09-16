require 'rails_helper'

RSpec.describe "Borrowing Spec 2/?" do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @address = create(:address, user: @user1, address_second: "Apt 101")
    @user1.friends << @user2
    @user2.friends << @user1
    @book = create(:book)
    @user_book = create(:user_book, user: @user2, book: @book)
    @borrow_request = create(:borrow_request, borrower: @user1, user_book: @user_book)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
  end
  it "I am notified of new borrow requests on my dashboard" do
    visit user_dashboard_path

    within ".book-requests" do
      expect(page).to have_css(".pending-requests")
    end

    within ".pending-requests" do
      request = find((".request"), match: :first)
      expect(request).to have_content("#{@user1.full_name} wants to borrow #{@book.title}")
      expect(request).to have_button("Accept")
      expect(request).to have_button("Decline")
    end
  end
  it "I can accept a request from the dashboard" do
    visit user_dashboard_path

    within ".pending-requests" do
      request = find(first(".request"))
      expect(request).to have_content("#{@user1.full_name} wants to borrow #{@book.title}")
      click_button("Accept")
    end
    expect(current_path).to eq(borrow_path(@borrow_request))
  end
end

# As a user (lender),
# When a friend asks to borrow one of my books,
# I can see the request on the dashboard.
# I am given an option to accept or deny the request.
# Accepting the request takes me to the request show page,
# Where I can see my friends mailing address and a confirmation link that I am sending the book.
#
# Denying the request will send a notification to my friend, and the request is removed from my dashboard.
