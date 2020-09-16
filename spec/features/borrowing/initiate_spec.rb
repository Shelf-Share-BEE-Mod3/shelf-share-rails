require "rails_helper"

RSpec.describe "Borrowing Spec 1/?" do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @user1.friends << @user2
    @book = create(:book)
    @user_book = create(:user_book, user: @user2, book: @book)
  end

  it "I can send a borrow request from my friend's book show page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    expect do
      visit books_path
      click_link @book.title
      click_button "Ask to Borrow"
    end.to change { BorrowRequest.count }.by(1)

    expect(current_path).to eq('/borrow/new')

    expect(page).to have_content("You are requesting to borrow #{@book.title} from #{@user1.full_name}")
    expect(page).to have_content("This request will permit #{@user1.first_name} to see your address information")

    expect(current_path).to eq(books_path)
    expect(page).to have_content("Borrow Request sent to #{@user2.full_name}")
  end
end
