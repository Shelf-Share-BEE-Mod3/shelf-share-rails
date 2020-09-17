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

    expect(@borrow_request.status).to eq('pending')
    expect(@user_book.status).to eq('available')

    within ".pending-requests" do
      request = find((".request"), match: :first)
      click_button("Accept")
    end

    @borrow_request.reload
    @user_book.reload

    expect(current_path).to eq(borrow_path(@borrow_request))
    expect(@borrow_request.status).to eq('accepted')
    expect(@user_book.status).to eq('unavailable')


    within ".address" do
      warning = "This is the only time you'll be shown #{@user1.full_name}'s address. Write it down!"
      expect(page).to have_content(warning)

      expect(page).to have_content(@address.address_first)
      expect(page).to have_content(@address.address_second)
      expect(page).to have_content(@address.city)
      expect(page).to have_content(@address.state)
      expect(page).to have_content(@address.zip)
    end

    visit user_dashboard_path
    within ".pending-requests" do
      expect(page).to_not have_css(".request")
    end
  end

  it "I can decline a request from the dashboard" do
    visit user_dashboard_path

    expect(@borrow_request.status).to eq('pending')
    expect(@user_book.status).to eq('available')

    within ".pending-requests" do
      request = find((".request"), match: :first)
      click_button("Decline")
    end

    @borrow_request.reload
    @user_book.reload

    expect(current_path).to eq(user_dashboard_path)

    expect(@borrow_request.status).to eq('declined')
    expect(@user_book.status).to eq('available')

    expect(page).to have_content("You have declined #{@user1.first_name}'s request to borrow #{@book.title}")

    within ".pending-requests" do
      expect(page).to_not have_css(".request")
    end
  end
end
