# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Book Index Page' do
  before :each do
    login_as_user
    @book1 = create(:book)
    @book2 = create(:book)
    # @book1.user_booka.create(user_id: current_user.id, status: 'available')
    # @book2.userbook.create(user_id: current_user.id, status: 'available')
  end

  it 'My books show up on the shelf' do
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book1.id,
                      status: 'available'
                    })
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book2.id,
                      status: 'unavailable'
                    })
    visit user_books_path
    expect(page).to have_css("img[src*='#{@book1.thumbnail}']")
    expect(page).to have_css("img[src*='#{@book2.thumbnail}']")
    expect(page).to have_content("On The Shelf")
    expect(page).to have_content("Off The Shelf")
    expect(page).to have_css(".available_book", count: 1)
    expect(page).to have_css(".unavailable_book", count: 1)
  end

  it 'If I have no available books, the page will indicate it' do
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book1.id,
                      status: 'unavailable'
                    })
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book2.id,
                      status: 'unavailable'
                    })
    visit user_books_path
    expect(page).to have_css("img[src*='#{@book1.thumbnail}']")
    expect(page).to have_css("img[src*='#{@book2.thumbnail}']")
    expect(page).to have_content("No books are currently available")
    expect(page).to have_css(".unavailable_book", count: 2)
  end

  it 'If I have no unavailable books, the page will indicate it' do
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book1.id,
                      status: 'available'
                    })
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book2.id,
                      status: 'available'
                    })
    visit user_books_path
    expect(page).to have_css("img[src*='#{@book1.thumbnail}']")
    expect(page).to have_css("img[src*='#{@book2.thumbnail}']")
    expect(page).to have_content("No books are currently unavailable")
  end

  it "The book cover is a link that takes me to the user book show page" do
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book1.id,
                      status: 'available'
                    })
    UserBook.create({
                      user_id: current_user.id,
                      book_id: @book2.id,
                      status: 'unavailable'
                    })
    visit user_books_path
    within('.available_book') do
      find(:xpath, "//a[contains(@href,#{@book1.id})]").click
    end
    expect(current_path).to eq(user_book_path(@book1))
  end
end
