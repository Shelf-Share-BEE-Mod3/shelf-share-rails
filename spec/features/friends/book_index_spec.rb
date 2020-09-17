require 'rails_helper'

RSpec.describe 'Friend Book Index Page' do
  before :each do
    login_as_user
    @friend1 = create(:user)
    @book1 = create(:book, id: 111)
    @book2 = create(:book, id: 2222, thumbnail: "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg")
    @book3 = create(:book, id: 345, thumbnail: "https://image.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-260nw-1037719192.jpg")
    @friend1.user_books.create!(book_id: @book1.id, status: 'available')
    @friend1.user_books.create!(book_id: @book2.id, status: 'available')
    @ub2 = @friend1.user_books.create!(book_id: @book3.id, status: 'unavailable')
    current_user.friendships.create!(friend_id: @friend1.id)
    @friend1.friendships.create!(friend_id: current_user.id)
    current_user.borrow_requests.create!(user_book: @ub2, status: 2)

    @book4 = create(:book, id: 97, thumbnail: "https://icons-for-free.com/iconfiles/png/512/mountains+photo+photos+placeholder+sun+icon-1320165661388177228.png")
    @ub_user = current_user.user_books.create(book_id: @book4.id, status: 'unavailable')
    @friend1.borrow_requests.create!(user_book: @ub_user, status: 2)
  end

  it "I can visit a friends book index page, and it shows all of the friends available books" do
    visit "/user/friends/#{@friend1.id}"
    expect(page).to have_content("#{@friend1.first_name}'s Books")
    expect(page).to have_css("img[src*='#{@book1.thumbnail}']")
    expect(page).to have_css("img[src*='#{@book2.thumbnail}']")
    expect(page).to have_css("img[src*='#{@book3.thumbnail}']")

    expected_count = @friend1.books.available.count
    expect(page).to have_css(".available_book", count: expected_count)

    within "#book-#{@book1.id}" do
      book_link = find(:xpath, "//a[contains(@href,#{@book1.id})]")
      book_link.click
    end

    expect(current_path).to eq("/books/#{@book1.id}")
  end

  it 'The view page will show books that I am borrowing from my friend' do
    visit "/user/friends/#{@friend1.id}"
    expect(page).to have_css(".borrowed_from_user", count: 1)
    within('.borrowed_from_user') do
      find(:xpath, "//a[contains(@href,#{@book3.id})]")
    end
  end

  it 'The view page will show books that I am lending to my friend' do
    visit "/user/friends/#{@friend1.id}"
    expect(page).to have_css(".lent_to_user", count: 1)
    within('.lent_to_user') do
      find(:xpath, "//a[contains(@href,#{@book4.id})]").click
    end
    expect(current_path).to eq("/books/#{@book4.id}")
  end
end
