class CreateBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :borrow_requests do |t|
      t.integer :status
      t.datetime :borrowed_at
      t.datetime :returned_at
      t.references :user_book, foreign_key: true

      t.timestamps
    end
  end
end
