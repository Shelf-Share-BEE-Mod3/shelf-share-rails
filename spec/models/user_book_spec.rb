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
    it "finds available user_books" do
      expect(UserBook.find_available_userbooks).to eq([@ub1])
    end
    it "finds unavailable user_books" do
      expect(UserBook.find_unavailable_userbooks).to eq([@ub2])
    end
  end
end
