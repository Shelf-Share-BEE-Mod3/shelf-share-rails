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
end
