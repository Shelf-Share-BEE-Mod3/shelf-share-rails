# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :token
      t.string :refresh_token
      t.datetime :oauth_expires_at
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
