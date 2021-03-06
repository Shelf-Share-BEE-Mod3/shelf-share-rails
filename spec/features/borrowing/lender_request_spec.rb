require 'rails_helper'

RSpec.describe "Borrowing Spec 2/?" do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @address1 = create(:address, user: @user1, address_second: "Apt 101")
    @address2 = create(:address, user: @user2, address_second: "Apt 222")
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
      expect(page).to have_content("You have 1 new book request")
    end
  end

  it "Each borrow request has buttons to approve or decline" do
    visit borrow_index_path

    request = find((".book-request"), match: :first)
    expect(request).to have_button "Approve"
    expect(request).to have_button "Decline"
  end

  it "I can accept a borrow request and see the borrrower's address" do
    visit borrow_index_path

    expect(@borrow_request.status).to eq('pending')
    expect(@user_book.status).to eq('available')

    request = find((".book-request"), match: :first)
    within request do
      click_button "Approve"
    end

    expect(current_path).to eq(address_path(@address1))
    expect(page).to have_content(@address1.address_first)
    expect(page).to have_content(@address1.address_second)
    expect(page).to have_content(@address1.city)
    expect(page).to have_content(@address1.state)
    expect(page).to have_content(@address1.zip)

    @borrow_request.reload
    @user_book.reload

    expect(@borrow_request.status).to eq('accepted')
    expect(@user_book.status).to eq('unavailable')

    visit borrow_index_path
    expect(page).to_not have_css(".book-request")
  end

  it "I can decline a request" do
    visit borrow_index_path

    expect(@borrow_request.status).to eq('pending')
    expect(@user_book.status).to eq('available')

    request = find((".book-request"), match: :first)
    within request do
      click_button "Decline"
    end

    @borrow_request.reload
    @user_book.reload

    expect(current_path).to eq(user_dashboard_path)

    expect(@borrow_request.status).to eq('declined')
    expect(@user_book.status).to eq('available')

    expect(page).to have_content("You have declined #{@user1.first_name}'s request to borrow #{@book.title}")

    visit borrow_index_path
    expect(page).to_not have_css(".book-request")
  end
end
