# frozen_string_literal: true

class UserBook < ApplicationRecord
  belongs_to :user
  has_many :borrow_requests
  belongs_to :book

  validates_presence_of :status, :user_id

  def self.find_available_userbooks
    where(status: 'available')
  end

  def self.find_unavailable_userbooks
    where.not(status: 'available')
  end
end
