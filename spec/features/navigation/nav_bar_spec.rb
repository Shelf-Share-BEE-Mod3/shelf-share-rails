require 'rails_helper'

RSpec.describe "Navigation Bar" do
  it "has the correct content" do
    visit root_path

    within "nav" do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Find Books")
      expect(page).to have_link("Friends")
      expect(page).to have_link("My Books")
      expect(page).to have_link("Account Info")
    end
    # Check for links to have the correct xpath once routes exist
  end
end
