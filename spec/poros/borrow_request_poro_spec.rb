require 'rails_helper'

RSpec.describe BorrowRequestPoro, type: :model do
  it 'exists' do
    expect(BorrowRequestPoro.new).to be_instance_of(BorrowRequestPoro)
  end
end
