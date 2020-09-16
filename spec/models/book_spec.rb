require "rails_helper"

RSpec.describe Book do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :author }
    it { should validate_presence_of :description }
    it { should validate_presence_of :isbn }
    it { should validate_uniqueness_of :isbn }
    it { should validate_presence_of :category }
    it { should validate_presence_of :thumbnail }
  end

  describe "instance_methods" do
    it "#find_status" do
      user = create(:user)
      book1 = create(:book)
      book2 = create(:book)
      user.user_books.create!(book_id: book1.id, status: 'available')
      user.user_books.create!(book_id: book2.id, status: 'unavailable')

      expect(book1.find_status).to eq('available')
      expect(book2.find_status).to eq('unavailable')
    end
  end
  describe 'class methods' do
    it 'search' do
      book1 = create(:book)
      book2 = create(:book)
      book3 = create(:book)

      # Exact matches
      expect(Book.search(book1.title)).to eq([book1])
      expect(Book.search(book1.author)).to eq([book1])
      expect(Book.search(book1.isbn)).to eq([book1])
      expect(Book.search(book1.description)).to eq([book1])

      # fragments
      expect(Book.search(book2.title[1..4])).to eq([book2])
      expect(Book.search(book2.author[0..2])).to eq([book2])
      expect(Book.search(book2.isbn[7..12])).to eq([book2])
      expect(Book.search(book2.description[0..5])).to eq([book2])
    end
  end
end
