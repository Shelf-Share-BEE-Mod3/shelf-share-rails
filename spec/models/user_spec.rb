# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many :friend_requests }
    it { should have_many :user_books }
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
end
