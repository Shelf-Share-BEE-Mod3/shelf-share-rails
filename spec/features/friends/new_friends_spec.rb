require 'rails_helper'

RSpec.describe "User Can Add friends" do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @user2 = User.create!(first_name: 'John', last_name: 'Scalzi', email: 'email@email.com')
    @user3 = User.create!(first_name: 'Robert', last_name: 'Heinlein')
  end
  it "with a valid email" do
    visit user_friends_path

    fill_in :email, with: @user2.email
    click_on 'Add Friend'

    expect(current_path).to eq(user_friends_path)
    expect(page).to have_content("Friend Request sent to #{@user2.first_name}")
    expect(@user2.friend_requests.size).to eq(1)
  end
  it "fails with an invalid email" do
    visit user_friends_path

    fill_in :email, with: 'notanemail@email.com'
    click_on 'Add Friend'

    expect(current_path).to eq(user_friends_path)
    expect(page).to have_content('No users with that email')
  end

end
