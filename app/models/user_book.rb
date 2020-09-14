class UserBook < ApplicationRecord
  belongs_to :user

  validates_presence_of :status, :user_id, :isbn

  def self.find_available_books
    where(status: 'available')
  end

  def self.find_unavailable_books
    where.not(status: 'available')
  end
end
