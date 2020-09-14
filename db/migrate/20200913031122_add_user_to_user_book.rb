# frozen_string_literal: true

class AddUserToUserBook < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_books, :user, foreign_key: true
  end
end
