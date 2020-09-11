require 'rails_helper'

RSpec.feature 'As a user' do
  scenario 'I can login using google oauth2' do
    login_as_user
    expect(page).to have_content('Welcome Lito White!')
    expect(page).to have_link('Logout')
  end
end
