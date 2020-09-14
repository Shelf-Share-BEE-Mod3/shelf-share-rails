# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'As a user' do
  scenario 'I can logout after signing in' do
    login_as_user
    click_link('Logout')
    expect(page).to have_content('Sign in with Google')
  end
end
