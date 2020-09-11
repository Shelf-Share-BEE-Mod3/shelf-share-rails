require 'rails_helper'

RSpec.feature "user logs in" do

  scenario "using google oauth2" do
    login_as_user
    expect(page).to have_content("Welcome Lito White!")
    expect(page).to have_link("Logout")
  end
end
