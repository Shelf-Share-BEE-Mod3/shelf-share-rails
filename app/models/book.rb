class Book < ApplicationRecord
  validates_presence_of :title, :author, :description, :thumbnail, :isbn, :category
  validates_uniqueness_of :isbn
end
