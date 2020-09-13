require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :isbn }
  end

  describe 'relationships' do
    it { should belong_to :user}
  end

  describe 'class methods' do
    before :each do
    @user = User.create(id: 1)
    @ub1 = UserBook.create({
      user_id: @user.id,
      isbn: "123456789",
      status: "available"
      })
    @ub2 = UserBook.create({
      user_id: @user.id,
      isbn: "987654321",
      status: "unavailable"
      })
    end

    it "find_available_books" do
      expect(UserBook.find_available_books).to eq([@ub1])
    end

    it "find_unavailable_books" do
      expect(UserBook.find_unavailable_books).to eq([@ub2])
    end
  end
end
