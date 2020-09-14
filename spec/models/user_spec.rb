require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many :friend_requests }
    it { should have_many :user_books }
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
        expires_at: DateTime.new(2020,9,12,3,4,5)
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
end
