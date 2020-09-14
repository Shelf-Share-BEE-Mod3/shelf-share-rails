# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_first
      t.string :address_second
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
