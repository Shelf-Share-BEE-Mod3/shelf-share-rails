class AddBorrowerToBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :borrow_requests, :borrower, references: :users, index: true
    add_foreign_key :borrow_requests, :users, column: :borrower_id
  end
end
