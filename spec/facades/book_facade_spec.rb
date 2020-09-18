require 'rails_helper'

RSpec.describe BookFacade, type: :facade do
  describe  'class methods' do
    it 'find_by_isbn(isbn)', :vcr do
      isbn = 1234512345123
      isbn2 = 9780143111580
      book = create(:book, isbn: isbn)
      expect(BookFacade.find_by_isbn(isbn)).to eq(book)
      expect(BookFacade.find_by_isbn(isbn2)).to_not eq(book)
      expect(BookFacade.find_by_isbn(isbn2)).to eq(Book.last)
    end
  end
end
