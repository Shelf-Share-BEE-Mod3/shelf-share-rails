class AddBooksToUserBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_books, :book, foreign_key: true
    remove_column :user_books, :isbn
  end
end
