# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :book }
    it { should have_many :borrow_requests }
  end

  describe 'class methods' do
    before :each do
      @book1 = create(:book)
      @book2 = create(:book)
      @book3 = create(:book)
      @user = User.create(id: 1)
      @user2 = User.create(id: 2)
      @user.friends << @user2
      @ub1 = UserBook.create({
                               user_id: @user.id,
                               book_id: @book1.id,
                               status: 'available'
                             })
      @ub2 = UserBook.create({
                               user_id: @user.id,
                               book_id: @book2.id,
                               status: 'unavailable'
                             })
      @ub3 = UserBook.create({
                              user_id: @user.id,
                              book_id: @book3.id,
                              status: 'unavailable'
                            })
      @borrow_request = create(:borrow_request, borrower: @user2, user_book: @ub3, status: 2 )

    end
    it "finds available user_books" do
      expect(UserBook.find_available_userbooks).to eq([@ub1])
    end
    it "finds unavailable user_books" do
      expect(UserBook.find_unavailable_userbooks).to eq([@ub2, @ub3])
    end
    it "find userbooks that are lent to a user" do
      expect(UserBook.userbooks_lent_to_user(@user2)).to eq([@ub3])
    end
  end

  describe 'instance methods' do
    before :each do
      @book1 = create(:book)
      @book2 = create(:book)
      @book3 = create(:book)
      @user = User.create(id: 1)
      @ub1 = UserBook.create({
                               user_id: @user.id,
                               book_id: @book1.id,
                               status: 'available'
                             })
      @ub2 = UserBook.create({
                               user_id: @user.id,
                               book_id: @book2.id,
                               status: 'unavailable'
                             })
    end
    it "find book object from userbook " do
      expect(@ub1.find_book_from_userbook).to eq(@book1)
      expect(@ub2.find_book_from_userbook).to eq(@book2)
    end
    it "can change the books status to available" do
      expect(@ub2.status_change_to_available).to eq(@ub2.status = "available")
    end
  end
end
