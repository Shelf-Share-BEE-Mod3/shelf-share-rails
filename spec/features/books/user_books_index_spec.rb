# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Book Index Page' do
  before :each do
    login_as_user
    @book1 = create(:book)
    @book2 = create(:book)
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
    expect(page).to have_content(@book1.title)
    expect(page).to have_content(@book2.title)
    expect(page).to have_content("On The Shelf")
    expect(page).to have_content("Off The Shelf")
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
    expect(page).to have_content(@book1.title)
    expect(page).to have_content(@book2.title)
    expect(page).to have_content("On The Shelf")
    expect(page).to have_content("Off The Shelf")
    expect(page).to have_content("No books are currently available")
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
    expect(page).to have_content(@book1.title)
    expect(page).to have_content(@book2.title)
    expect(page).to have_content("On The Shelf")
    expect(page).to have_content("Off The Shelf")
    expect(page).to have_content("No books are currently unavailable")
  end
end
