require 'rails_helper'

RSpec.describe "Navigation Bar" do
  it "has the correct content" do
    visit root_path

    within "nav" do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("Dashboard", href: dashboard_path)
      expect(page).to have_link("Find Books", href: books_path)
      expect(page).to have_link("Friends", href: user_friends_path)
      expect(page).to have_link("My Books", href: user_books_path)
      expect(page).to have_link("Account Info", href: user_account_path)
    end
    # Check for links to have the working xpath once routes exist
  end
end
