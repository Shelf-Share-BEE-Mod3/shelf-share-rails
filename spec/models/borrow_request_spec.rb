require "rails_helper"

RSpec.describe BorrowRequest do
  describe "validations" do
    it { should validate_presence_of :borrower_id }
    it { should validate_presence_of :user_book_id }
    it { should define_enum_for(:status).with_values([:pending, :declined, :accepted, :returned]) }
  end

  describe "associations" do
    it { should belong_to :borrower }
    it { should belong_to :user_book }
  end

  describe 'status enum' do
    before :each do
      @user1, @user2 = create_list(:user, 2)
      @book = create(:book)
      @userbook = @user1.user_books.create!(book_id: @book.id, status: 'available')
    end
    it 'pending' do
      req = @user2.borrow_requests.create!(user_book_id: @userbook.id, status: 0)
      expect(req.status).to eq('pending')
    end
    it 'declined' do
      req = @user2.borrow_requests.create!(user_book_id: @userbook.id, status: 1)
      expect(req.status).to eq('declined')
    end
    it 'accepted' do
      req = @user2.borrow_requests.create!(user_book_id: @userbook.id, status: 2)
      expect(req.status).to eq('accepted')
    end
    it 'returned' do
      req = @user2.borrow_requests.create!(user_book_id: @userbook.id, status: 3)
      expect(req.status).to eq('returned')
    end
  end

  describe 'class methods' do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @book1 = create(:book)
      @ub1 = UserBook.create({
                               user_id: @user2.id,
                               book_id: @book1.id,
                               status: 'available'
                             })
      @borrow_request = BorrowRequest.create({
                              borrower_id: @user1.id,
                              user_book_id: @ub1.id,
                              status: 2
                            })
    end

    it "can find all approved borrow requests" do
      expect(BorrowRequest.find_approved_requests).to eq([@borrow_request])
    end
    it "can change status of returned book to returned" do
      expect(@borrow_request.status_changed_to_returned).to eq(@borrow_request.status = 3)
    end
  end
end
