# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :user_id }
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
                               status: 'available'
                             })
      @ub2 = UserBook.create({
                               user_id: @user.id,
                               status: 'unavailable'
                             })
    end
  end
end
