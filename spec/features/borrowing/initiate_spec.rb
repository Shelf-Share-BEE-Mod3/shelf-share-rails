require "rails_helper"

RSpec.describe "Borrowing Spec 1/?" do
  it "I can send a book borrow request to my friend"

  # TODO
  # if i don't have an address when i ask to borrow, i will be prompted to do so

  # creating a borrow request will:
  # 1. record a borrow request with a status pending
  # 2. remove the option for me to ask again for that book

  # the pattern is back and forth between users, like friend requests

  # it should not affect the status of any user_book records

  # it needs to be tested in the browser
end
