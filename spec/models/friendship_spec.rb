# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }
  end
end
