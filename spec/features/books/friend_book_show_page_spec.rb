require 'rails_helper'

RSpec.describe 'Friend Book Show Page Spec' do
  before :each do
    @user1, @user2 = create_list(:user, 2)
    @user2.user_books.create!(isbn: '9780765370624', status: 'available')
    @book = @user2.books.first
    @user1.friends << @user2
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it "I can visit my friend's book show page from the books_path" do
    visit books_path
    within(first('.friend-book-shelf')) do
      click_link @book.title
    end

    expect(current_path).to eq(book_path(@book))

    expect(page).to have_content(@book.title)
    expect(page).to have_content(@book.author)
    expect(page).to have_content("Belongs to #{@user2.first_name}")
    expect(page).to have_content(@book.description)
    expect(page).to have_content(@book.category)
    expect(page).to have_css("img[src*='#{@book.thumbnail}']")
  end
end
