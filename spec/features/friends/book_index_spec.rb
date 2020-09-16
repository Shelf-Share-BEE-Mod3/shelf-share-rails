require 'rails_helper'

RSpec.describe 'Friend Book Index Page' do
  before :each do
    login_as_user
    @friend1 = create(:user)
    @friend1_books = create_list(:book, 3)
    @friend1.user_books.create!(book_id: @friend1_books[0].id, status: 'available')
    @friend1.user_books.create!(book_id: @friend1_books[1].id, status: 'available')
    @ub2 = @friend1.user_books.create!(book_id: @friend1_books[2].id, status: 'unavailable')
    current_user.friendships.create!(friend_id: @friend1.id)
    @friend1.friendships.create!(friend_id: current_user.id)
    current_user.borrow_requests.create!(user_book: @ub2, status: 2)
  end

  it "I can visit a friends book index page, and it shows all of that friends available books" do

    visit "/user/friends/#{@friend1.id}"
    expect(page).to have_content("#{@friend1.first_name}'s Books")
    expect(page).to have_css("img[src*='#{@friend1_books[0].thumbnail}']")
    expect(page).to have_css("img[src*='#{@friend1_books[1].thumbnail}']")
    expect(page).to have_css("img[src*='#{@friend1_books[2].thumbnail}']")

    expected_count = @friend1_books.count
    expect(page).to have_css(".available_book", count: expected_count)

    book_link = find(:xpath, "//a[contains(@href,#{@friend1_books[0].id})]")
    book_link.click
    expect(current_path).to eq("/books/#{@friend1_books[0].id}")
  end

  xit 'The view page will show books that my friend is lending to me' do
    visit "/user/friends/#{@friend1.id}"
    expect(page).to have_css(".lent_to_user", count: 1)
    book_link = find(:xpath, "//a[contains(@href,#{@friend1_books[2].id})]")
  end
end
