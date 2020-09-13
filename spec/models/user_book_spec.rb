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
end
