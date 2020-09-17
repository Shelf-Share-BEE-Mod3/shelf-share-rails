require 'rails_helper'

RSpec.describe 'Find books search feature' do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit books_path

    @user2 = User.create!(first_name: 'John', last_name: 'Scalzi')
    @user3 = User.create!(first_name: 'Robert', last_name: 'Heinlein')

    @user.friends << @user2
    @user2.friends << @user
    @user.friends << @user3
    @user3.friends << @user

    5.times do
      create(:book)
    end

    Book.create!(title: 'Meditations',
      author: 'Marcus Aurelius',
      description: 'For the Stoic',
      isbn: 1231231234567,
      category: 'Philosophy',
      thumbnail: 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Indian_Election_Symbol_Book.svg'
    )

    Book.all.each do |book|
      @user2.user_books.create!(book_id: book.id, status: 'available')
    end
  end

  describe 'As a registered user' do
    it 'When I visit the find books page, I see a keyword search box' do
      within ".search-books" do
        expect(page.has_field? :search).to be_truthy
      end
    end

    it 'When I fill in the text field with a book title and click the find books button, I am redirected to the books index where I see the results for my search' do

      within ".search-books" do
        fill_in :search, with: "Meditations"
        click_on "Find Books"
      end
      expect(current_path).to eq(books_search_index_path)
      expect(page).to have_content("Meditations")
    end

    it 'Only books of my friends will be displayed' do
      @user4 = create(:user)
      @user4_book = create(:book, title: 'Meditations on a Rock')
      UserBook.create!(book_id: @user4_book.id, user_id: @user4.id, status: 'available')
      within ".search-books" do
        fill_in :search, with: "Meditations"
        click_on "Find Books"
      end
      expect(page).to_not have_content("Meditations on a Rock")
    end
  end
end
