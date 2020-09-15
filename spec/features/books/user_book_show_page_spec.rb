require 'rails_helper'

RSpec.describe 'Friend Book Show Page Spec' do
  before :each do
    @user1 = create(:user)
    @user1.user_books.create!(isbn: '9780765370624', status: 'available')
    @available_book = @user1.books.first
    @user1.user_books.create!(isbn: '9781594133299', status: 'unavailable')
    @unavailable_book = @user1.books.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it "I can visit my book show page for an available book in my shelf" do
    visit user_books_path

    click_link @available_book.title
    expect(current_path).to eq(book_path(@available_book))

    expect(page).to have_content(@available_book.title)
    expect(page).to have_content(@available_book.author)
    expect(page).to have_content(@available_book.description)
    expect(page).to have_content(@available_book.category)
    expect(page).to have_css("img[src*='#{@available_book.thumbnail}']")
  end

  it "I can visit my book show page for an UNavailable book in my shelf" do
    visit user_books_path

    click_link @unavailable_book.title
    expect(current_path).to eq(book_path(@unavailable_book))

    expect(page).to have_content(@unavailable_book.title)
    expect(page).to have_content(@unavailable_book.author)
    expect(page).to have_content(@unavailable_book.description)
    expect(page).to have_content(@unavailable_book.category)
    expect(page).to have_css("img[src*='#{@unavailable_book.thumbnail}']")
  end
end
