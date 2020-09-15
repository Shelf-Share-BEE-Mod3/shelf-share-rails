require 'rails_helper'

RSpec.describe "Find Books Index" do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @user2 = User.create!(first_name: 'John', last_name: 'Scalzi')
    @user3 = User.create!(first_name: 'Robert', last_name: 'Heinlein')

    5.times do
      @user2.user_books.create(
        status: 'available',
        isbn: Faker::Code.isbn(base: 13).tr('-', '')
      )
    end

    5.times do
      @user3.user_books.create(
        status: 'available',
        isbn: Faker::Code.isbn(base: 13).tr('-', '')
      )
    end

    attributes = {
      data: {
        id: '1',
        type: 'book',
        attributes: { title: "Ender's Game",
          author: 'Orson Scott Card',
          description: "An expert at simulated war games, Andrew \"Ender\" Wiggin believes that he is engaged in one more computer war game when, in truth, he is commanding the last Earth fleet against an alien race seeking Earth's complete destruction.",
          thumbnail: 'http://books.google.com/books/content?id=WEW1cC7yaCQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
          isbn: '9780765370624',
          category: 'Fiction'
          }
        }
      }

    allow(BookBuddyService).to receive(:find_by_isbn).and_return(attributes)

    @user.friends << @user2
    @user.friends << @user3
  end
  xit "shows list of books organized by friend" do
    visit books_path

    book = Book.first

    expect(page).to have_content("Browse Books")
    expect(page).to have_content("Sorted by Friend")
    expect(page).to have_css('.friend-book-shelf', count: 2)
    expect(page).to have_css('.book', count: 10)
    within(first(".book")) do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.author)
      expect(page).to have_content(book.category)
      expect(page).to have_css("img[src*='#{book.thumbnail}']")
    end
  end
end

# I see lists of book covers organized by friend or genre
# I see an option to toggle so organization between friend or genre
# Each book cover is a link to that book's show page
# When organized by genre, I do not see repeats of books even if several friends have the same book on their shelf
