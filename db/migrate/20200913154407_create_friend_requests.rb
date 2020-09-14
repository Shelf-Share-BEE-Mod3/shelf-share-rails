# frozen_string_literal: true

class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :user, foreign_key: true
      t.bigint :from
      t.integer :status

      t.timestamps
    end
  end
end
