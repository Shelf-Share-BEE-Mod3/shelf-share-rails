require 'rails_helper'

RSpec.describe 'User Friends Index Page' do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'has a list of current_users friends' do
    visit user_dashboard_path

    expect(page).to have_css(".friend-list")

  end

  it 'has a form to search and add friends' do
    visit user_dashboard_path

    expect(page).to have_css(".add-friend-form")

    expect(page).to have_content("Add Friends")
  end
end

# As a registered user
# When I visit the friends index page
# I see a search box to add friend's by their email
# I see a list of my friends
# I see any new friends requests and buttons to accept or decline
# I see the book covers I am lending displayed by the friend who has them
# I see the book covers of books I am borrowing by the friends who own them
