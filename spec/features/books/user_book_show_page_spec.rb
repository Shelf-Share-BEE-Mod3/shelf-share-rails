require 'rails_helper'

RSpec.describe 'Friend Book Show Page Spec' do
  before :each do
    @user1 = create(:user)
    @book1, @book2 = create_list(:book, 2)
    @user1.user_books.create!(book_id: @book1.id, status: 'available')
    @available_book = @user1.books.first
    @user1.user_books.create!(book_id: @book2.id, status: 'unavailable')
    @unavailable_book = @user1.books.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it "I can visit my book show page for an available book in my shelf" do
    visit user_books_path

    click_link @available_book.title
    expect(current_path).to eq(user_book_path(@available_book))
  end

  it "I can visit one of my book show page" do
    visit user_book_path(@available_book)
    expect(page).to have_content(@available_book.title)
    expect(page).to have_content(@available_book.author)
    expect(page).to have_content(@available_book.description)
    expect(page).to have_content(@available_book.category)
    expect(page).to have_content(@available_book.find_status)
    expect(page).to have_css("img[src*='#{@available_book.thumbnail}']")
    expect(page).to have_button("Change Status")
    expect(page).to have_button("Remove Book")
  end

  it "I can visit my book show page for an UNavailable book in my shelf" do
    visit user_books_path

    click_link @unavailable_book.title
    expect(current_path).to eq(user_book_path(@unavailable_book))
  end

  it "I can visit another one of my book show page" do
    visit user_book_path(@unavailable_book)
    expect(page).to have_content(@unavailable_book.title)
    expect(page).to have_content(@unavailable_book.author)
    expect(page).to have_content(@unavailable_book.description)
    expect(page).to have_content(@unavailable_book.category)
    expect(page).to have_content(@unavailable_book.find_status)
    expect(page).to have_css("img[src*='#{@unavailable_book.thumbnail}']")
    expect(page).to have_button("Change Status")
    expect(page).to have_button("Remove Book")
  end
  it "can remove a book from the shelf" do
    visit user_book_path(@available_book)
    expect(page).to have_content(@available_book.title)
    click_button 'Remove Book'
    expect(current_path).to eq(user_dashboard_path)
    expect(page).to_not have_content(@available_book.title)
  end
end
