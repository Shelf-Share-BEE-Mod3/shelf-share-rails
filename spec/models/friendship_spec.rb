# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }
  end
  describe 'class methods' do
    it 'can create and destroy friendships' do
      user1 = create(:user)
      user2 = create(:user)

      expect(Friendship.all.count).to eq(0)
      expect(user1.friends).to be_empty
      expect(user2.friends).to be_empty

      Friendship.create_reciprocal_for_ids(user1.id, user2.id)
      expect(Friendship.all.count).to eq(2)
      expect(user1.friends.count).to eq(1)
      expect(user2.friends.count).to eq(1)
      
      Friendship.destroy_reciprocal_for_ids(user1.id, user2.id)
      expect(Friendship.all.count).to eq(0)
      expect(user1.friends).to be_empty
      expect(user2.friends).to be_empty
    end
  end
end
