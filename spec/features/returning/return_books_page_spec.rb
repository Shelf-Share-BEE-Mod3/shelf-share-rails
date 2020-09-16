require 'rails_helper'

RSpec.describe 'Return Book Index Page' do
  before :each do
    login_as_user
    @user2 = create(:user)
    @address = create(:address, user: @user2, address_second: "Apt 101")
    current_user.friends << @user2
    @book = create(:book)
    @user_book = create(:user_book, user: @user2, book: @book)
    @borrow_request = create(:borrow_request, borrower: current_user, user_book: @user_book, status: 2 )

  end

  it 'On the dashboard, there is a link to show all books I am borrowing' do
    visit user_dashboard_path
    within ('.borrowed-books') do
      expect(page).to have_button("See all borrowed books")
    end
    click_button("See all borrowed books")
  end

  it "On the borrowed books index page, I see a list of all books I am borrowing" do

    visit "/return"
    expect(page).to have_css(".borrowed-books", count: 1)

  end


end
