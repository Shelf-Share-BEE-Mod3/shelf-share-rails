require "rails_helper"

RSpec.describe "Borrowing Spec 1/?" do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @address = create(:address, user: @user1, address_second: "Apt 101")
    @user1.friends << @user2
    @user2.friends << @user1
    @book = create(:book)
    @user_book = create(:user_book, user: @user2, book: @book)
  end

  it "I can send a borrow request from my friend's book show page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
    visit user_dashboard_path
    within ".book-requests" do
      expect(page).to have_content("No current requests")
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    expect(BorrowRequest.count).to eq(0)
    expect do
      visit books_path
      click_link @book.title
      click_button "Ask to Borrow"
    end.to change { BorrowRequest.count }.by(1)

    request = BorrowRequest.first
    expect(request.status).to eq("pending")

    expect(current_path).to eq(books_path)
    expect(page).to have_content("Borrow Request sent to #{@user2.full_name}")
    click_link @book.title
    expect(page).to_not have_button "Ask to Borrow"
  end
end
