# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'validations' do
    it { should validate_presence_of :from }
    it { should validate_presence_of :status }
  end
  describe 'relationships' do
    it { should belong_to :user }
  end
end
