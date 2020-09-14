# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :isbn }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'class methods' do
    before :each do
      @book1 = create(:book)
      @book2 = create(:book)
      @user = User.create(id: 1)
      @ub1 = UserBook.create({
                               user_id: @user.id,
                               isbn: @book1.isbn,
                               status: 'available'
                             })
      @ub2 = UserBook.create({
                               user_id: @user.id,
                               isbn: @book2.isbn,
                               status: 'unavailable'
                             })
    end

    it 'find_available_books' do
      expect(UserBook.find_available_books).to eq([@ub1])
    end

    it 'find_unavailable_books' do
      expect(UserBook.find_unavailable_books).to eq([@ub2])
    end
  end
end
