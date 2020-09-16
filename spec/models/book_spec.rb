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
  end
end
