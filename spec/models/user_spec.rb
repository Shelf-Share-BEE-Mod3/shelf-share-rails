# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many :friend_requests }
    it { should have_many :user_books }
    it { should have_many(:books).through(:user_books) }
    it { should have_many :borrow_requests}
  end

  it 'creates or updates itself from an oauth hash' do
    auth = {
      provider: 'google',
      uid: '12345678910',
      info: {
        email: 'lito@litowhite.com',
        first_name: 'Lito',
        last_name: 'White'
      },
      credentials: {
        token: 'abcdefg12345',
        refresh_token: '12345abcdefg',
        expires_at: DateTime.new(2020, 9, 12, 3, 4, 5)
      }
    }
    User.update_or_create(auth)
    new_user = User.first

    expect(new_user.provider).to eq('google')
    expect(new_user.uid).to eq('12345678910')
    expect(new_user.email).to eq('lito@litowhite.com')
    expect(new_user.first_name).to eq('Lito')
    expect(new_user.last_name).to eq('White')
    expect(new_user.token).to eq('abcdefg12345')
    expect(new_user.refresh_token).to eq('12345abcdefg')
    expect(new_user.oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end

  describe 'instance methods' do
    before :each do

      auth = {
        provider: 'google',
        uid: '12345678910',
        info: {
          email: 'lito@litowhite.com',
          first_name: 'Lito',
          last_name: 'White'
        },
        credentials: {
          token: 'abcdefg12345',
          refresh_token: '12345abcdefg',
          expires_at: DateTime.new(2020, 9, 12, 3, 4, 5)
        }
      }
      User.update_or_create(auth)
      @new_user = User.first

      @book1 = create(:book)
      @book2 = create(:book)
      @user = User.create(id: 1)
      @ub1 = UserBook.create({
                               user_id: @new_user.id,
                                book_id: @book1.id,
                               status: 'available'
                             })
      @ub2 = UserBook.create({
                               user_id: @new_user.id,
                               book_id: @book2.id,
                               status: 'unavailable'
                             })
    end

    it "can find available_books" do
      expect(@new_user.available_books).to eq([@book1])
    end

    it "can find unavailable_books" do
      expect(@new_user.unavailable_books).to eq([@book2])
    end
  end

  describe "full name instance method" do
    it "has a full name" do
      user = create(:user)
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
  describe 'incoming requests instance method' do
    before :each do
      @user1, @user2 = create_list(:user, 2)
      @user1.friends << @user2
      @user2.friends << @user1
      @book = create(:book)
      @book2 = create(:book)
      @user_book1 = create(:user_book, user: @user2, book: @book)
      @user_book2 = create(:user_book, user: @user2, book: @book2, status: 'unavailable')
      @borrow_request1 = create(:borrow_request, borrower: @user1, user_book: @user_book1)
      @borrow_request2 = create(:borrow_request, borrower: @user1, user_book: @user_book2, status: 2)
      # user1 is asking for a book from user2
    end
    it 'incoming_book_borrow_requests' do
      expect(@user2.incoming_book_borrow_requests).to include(@borrow_request1)
      expect(@user2.incoming_book_borrow_requests).to_not include(@borrow_request2)
    end
    it "find loaned_books" do
      expect(@user2.loaned_books).to include(@book2)
      expect(@user2.loaned_books).to_not include(@book)
    end
  end
end
