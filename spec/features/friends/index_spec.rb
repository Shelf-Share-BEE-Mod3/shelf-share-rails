# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Friends Index Page' do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @user2 = User.create!(first_name: 'John', last_name: 'Scalzi')
    @user3 = User.create!(first_name: 'Robert', last_name: 'Heinlein')
  end
  it 'displays no friends when current_user has no friends' do
    visit user_friends_path

    within '.friend-list' do
      expect(page).to have_content('no friends')
    end
  end

  it 'has a list of current_users friends' do
    @user.friends << @user2
    @user.friends << @user3

    visit user_friends_path

    within('.friend-list') do
      expect(page).to have_link(@user2.first_name)
      expect(page).to have_link(@user3.first_name)
    end
  end

  it 'has a form to search and add friends' do
    visit user_friends_path

    expect(page).to have_css('.add-friend-form')

    expect(page).to have_content('Add friends')
  end
end
