require 'rails_helper'

RSpec.describe 'Friend Book Index Page' do
  before :each do
    login_as_user
    @friend1 = create(:user)
    @friend1_books = create_list(:book, 3)
    @friend1.user_books.create!(book_id: @friend1_books[0].id, status: 'available')
    @friend1.user_books.create!(book_id: @friend1_books[1].id, status: 'available')
    @friend1.user_books.create!(book_id: @friend1_books[2].id, status: 'available')
    current_user.friendships.create(friend_id: @friend1.id)
  end

  it "I can visit a friends book index page" do
    visit user_friends_path
    within('.friend-list') do
      expect(page).to have_link(@friend1.first_name)
      click_link(@friend1.first_name)
    end

    expect(current_path).to eq("/user/friends/#{@friend1.id}")
    expect(page).to have_content("#{@friend1.first_name}'s Books")
    expect(page).to have_css("img[src*='#{@friend1_books[0].thumbnail}']")
    expect(page).to have_css("img[src*='#{@friend1_books[1].thumbnail}']")
    expect(page).to have_css("img[src*='#{@friend1_books[2].thumbnail}']")
    # expect(page).to have_link("img[src*='#{@friend1_books[0].thumbnail}']")

    expected_count = @friend1_books.count
    expect(page).to have_css(".book", count: expected_count)
    book_link = find(:xpath, "//a[contains(@href,#{@friend1_books[0].id})]")
    book_link.click

  end
end
