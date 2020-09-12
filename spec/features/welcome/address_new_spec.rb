require 'rails_helper'

RSpec.feature 'As a user' do
  before :each do
    login_as_user
    @address = {
      :address_first => '1984 Shelf Space',
      :address_second => 'Unit 451',
      :city => 'Castle Rock',
      :state => 'ME',
      :zip => '14101'
    }
  end

  scenario 'After logging in for the first time, there is a button on the welcome page to take me to the address entry form page' do
    expect(page).to have_button('Add Address')
  end

  scenario 'Clicking on the button sends me to a form to provide my address' do
    click_button 'Add Address'
    expect(current_path).to eq('/addresses/new')

    fill_in :address_first, with: @address[:address_first]
    fill_in :address_second, with: @address[:address_second]
    fill_in :city, with: @address[:city]
    fill_in :state, with: @address[:state]
    fill_in :zip, with: @address[:zip]

    expect(current_user.address).to be_falsey
    click_button 'Submit Address'
    expect(page).to have_content('Address successfully saved')
    expect(current_user.address).to be_truthy
  end

  scenario 'Submitting an incomplete form redirects me to the form page with a flash message indicating the error. All fields are pre-populated with what was initially submitted' do
    click_button 'Add Address'
    expect(current_path).to eq('/addresses/new')

    fill_in :address_first, with: @address[:address_first]
    fill_in :address_second, with: @address[:address_second]
    # fill_in :city, with: @address[:city]
    fill_in :state, with: @address[:state]
    fill_in :zip, with: @address[:zip]

    expect(current_user.address).to be_falsey
    click_button 'Submit Address'
    save_and_open_page
    expect(page).to have_content('Please fill out all required fields')
    expect(page).to have_content("City can't be blank")
    page.should have_field(:address_first, with: @address[:address_first])
    page.should have_field(:address_second, with: @address[:address_second])
    page.should have_field(:state, with: @address[:state])
    page.should have_field(:zip, with: @address[:zip])
  end
end
