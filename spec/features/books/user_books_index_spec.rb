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
                      isbn: @book1.isbn,
                      status: 'available'
                    })
    UserBook.create({
                      user_id: current_user.id,
                      isbn: @book2.isbn,
                      status: 'unavailable'
                    })
    visit 'user/books'
    expect(page).to have_content(@book1.isbn)
    expect(page).to have_content(@book2.isbn)
  end
end
