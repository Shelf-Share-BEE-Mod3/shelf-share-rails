class Book < ApplicationRecord
  validates_presence_of :title, :author, :description, :thumbnail, :isbn, :category
  validates_uniqueness_of :isbn

  def find_status
    UserBook.find_by(isbn: isbn).status
  end
end
