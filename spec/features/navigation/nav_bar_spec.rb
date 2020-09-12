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
  end
  it "has working paths for all links" do
    skip
  # Check for links to have the working xpath once routes exist
    visit root_path
    click_link "Dashboard"
    expect(current_path).to eq(dashboard_path)
    click_link "Find Books"
    expect(current_path).to eq(books_path)
    click_link "Friends"
    expect(current_path).to eq(user_friends_path)
    click_link "My Books"
    expect(current_path).to eq(user_books_path)
    click_link "Account Info"
    expect(current_path).to eq(user_account_path)
    click_link "Home"
    expect(current_path).to eq(root_path)
  end
end
