require "rails_helper"

RSpec.describe Book do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :author }
    it { should validate_presence_of :description }
    it { should validate_presence_of :isbn }
    it { should validate_uniqueness_of :isbn }
    it { should validate_presence_of :category }
    it { should validate_presence_of :thumbnail }
  end
  describe 'relationships' do
    it { should have_many :user_books }
    it { should have_many(:users).through(:user_books) }
  end
  describe "instance_methods" do
    it "#find_status" do
      user = create(:user)
      book1 = create(:book)
      book2 = create(:book)
      user.user_books.create!(book_id: book1.id, status: 'available')
      user.user_books.create!(book_id: book2.id, status: 'unavailable')

      expect(book1.find_status).to eq('available')
      expect(book2.find_status).to eq('unavailable')
    end
    it "#find_borrower" do
      lender = create(:user)
      borrower = create(:user)
      faker = create(:user)
      book1 = create(:book)
      book2 = create(:book)
      userbook1 = book1.user_books.create(user_id: lender.id, status: 'unavailable')
      userbook2 = book2.user_books.create(user_id: lender.id, status: 'unavailable')
      BorrowRequest.create!(user_book_id: userbook1.id, borrower_id: faker.id, status: 3)
      BorrowRequest.create!(user_book_id: userbook2.id, borrower_id: faker.id, status: 2)
      BorrowRequest.create!(user_book_id: userbook1.id, borrower_id: borrower.id, status: 2)
      expect(book1.find_borrower(lender.id)).to eq(borrower)
    end
  end

  describe "#class_methods" do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @book1 = create(:book)
      @book2 = create(:book)
      @userbook1 = @user1.user_books.create!(book_id: @book1.id, status: 'unavailable')
      @userbook2 = @user1.user_books.create!(book_id: @book2.id, status: 'available')
      @borrow_request = @userbook1.borrow_requests.create(borrower_id: @user2.id, status: 2)
    end

    it "#lent_to_user(id)" do
      expect(Book.lent_to_user(@user2.id)).to eq([@book1])
    end

    it "#available" do
      expect(Book.available).to eq([@book2])
    end

    it 'search' do
      book1 = create(:book, title: "Test Case")
      book2 = create(:book)
      book3 = Book.create!(
        title: 'Test Book',
        author: 'Author',
        description: 'This is a book',
        thumbnail: 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Indian_Election_Symbol_Book.svg',
        isbn: 1234123412341,
        category: 'Real Book'
      )

      # Exact matches
      expect(Book.search(book1.title).first).to eq(book1)
      expect(Book.search(book1.author).first).to eq(book1)
      expect(Book.search(book1.isbn).first).to eq(book1)
      expect(Book.search(book1.description).first).to eq(book1)

      # fragments
      expect(Book.search('Test')).to eq([book1,book3])
      expect(Book.search('author').first).to eq(book3)
      expect(Book.search('12341234').first).to eq(book3)
      expect(Book.search('book').first).to eq(book3)
    end

    it 'friends_books' do
      @user1.friends << @user2
      @user2.friends << @user1
      stranger = create(:user)
      book4 = create(:book, title: "Test Case")
      book5 = create(:book, title: "Test Book")
      UserBook.create!(book_id: book4.id, user_id: @user1.id, status: 'available')
      UserBook.create!(book_id: book5.id, user_id: stranger.id, status: 'available')
      expect(Book.find_friends_available_books(@user2.id)).to eq([@book2, book4])
    end
  end
end
