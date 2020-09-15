# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  after_initialize :set_status

  validates :from, presence: true, uniqueness: true
  validates :status, presence: true
  belongs_to :user

  enum status: %w[pending accepted declined]

  private

  def set_status
    self.status ||= 0
  end
end
