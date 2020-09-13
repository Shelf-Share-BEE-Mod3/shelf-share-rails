class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.string :status
      t.string :isbn
    end
  end
end
