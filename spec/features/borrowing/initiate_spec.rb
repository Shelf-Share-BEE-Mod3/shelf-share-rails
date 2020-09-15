require "rails_helper"

RSpec.describe "Borrowing Spec 1/?" do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @user1.friends << @user2
    @book = create(:book)
    create(:user_book, user: @user2, book: @book)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it "I can send a borrow request from my friend's book show page" do
    expect do
      visit books_path
      click_link @book.title
      click_button "Ask to Borrow"
    end.to change { BorrowRequest.count }.by(1)
  end
end
