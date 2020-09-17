# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Navigation Bar' do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    create(:address, user: @user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit root_path
  end
  it 'has the correct content' do
    within 'nav' do
      expect(page).to have_link('ShelfShare', href: root_path)
      expect(page).to have_link('Dashboard', href: user_dashboard_path)
      expect(page).to have_link('Books', href: books_path)
      expect(page).to have_link('Friends', href: user_friends_path)
      expect(page).to have_link('Profile', href: user_books_path)
      # expect(page).to have_link('Account Info', href: user_account_path)
      expect(page).to have_content("Logged in as #{@user.first_name}. (Logout)")
      expect(page).to have_link('Logout', href: logout_path)
    end
  end
  it 'has working paths for all links' do
    click_link 'Dashboard'
    expect(current_path).to eq(user_dashboard_path)
    click_link 'Books'
    expect(current_path).to eq(books_path)
    click_link 'Friends'
    expect(current_path).to eq(user_friends_path)
    click_link 'Profile'
    expect(current_path).to eq(user_books_path)
    # click_link 'Account Info'
    # expect(current_path).to eq(user_account_path)
    click_link 'ShelfShare'
    expect(current_path).to eq(root_path)
    within 'nav' do
      click_link 'Logout'
    end
    expect(current_path).to eq(root_path)
  end
end
