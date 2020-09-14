require 'rails_helper'

RSpec.describe 'Create User Books Spec' do
  it 'I can add a book by searching its ISBN' do
    book = {isbn: '9780441569595', title: 'Neuromancer', author: 'William Gibson'}

    login_as_user

    visit new_user_book_path
    fill_in :isbn, with: book[:isbn]
    click_button "Add Book to Shelf"

    expect(current_path).to eq(new_user_book_path)
    expect(page).to have_content("Added to Shelf: #{book[:title]}, by #{book[:author]}")

    visit user_books_path
    expect(page).to have_content(book[:isbn])
  end

  it 'I cannot add a book with an invalid ISBN' do
    login_as_user

    visit new_user_book_path
    fill_in :isbn, with: 'x'
    click_button "Add Book to Shelf"

    expect(current_path).to eq(new_user_book_path)
    expect(page).to have_content("Oops! That book cannot be found.")
  end
end
