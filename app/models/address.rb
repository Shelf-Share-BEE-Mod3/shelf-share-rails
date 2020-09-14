# frozen_string_literal: true

class Address < ApplicationRecord
  validates_presence_of :address_first, :city, :state, :zip
  belongs_to :user
end
