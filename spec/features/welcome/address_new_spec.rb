# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'As a user who did not add an address yet' do
  before :each do
    login_as_user
    @address = build(:address)
  end

  scenario 'My Shipping Information will tell me to add an address if I do not have one' do
    visit user_books_path
    click_link 'My Shipping Information'
    expect(current_path).to eq('/addresses/new')
    expect(page).to have_content("You haven't added an address yet. Please fill out the form below.")

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
    visit user_books_path
    click_link 'My Shipping Information'
    expect(current_path).to eq('/addresses/new')
    expect(page).to have_content("You haven't added an address yet. Please fill out the form below.")

    fill_in :address_first, with: @address[:address_first]
    fill_in :address_second, with: @address[:address_second]
    # fill_in :city, with: @address[:city]
    fill_in :state, with: @address[:state]
    fill_in :zip, with: @address[:zip]

    expect(current_user.address).to be_falsey
    click_button 'Submit Address'
    expect(page).to have_content('Please fill out all required fields')
    expect(page).to have_content("City can't be blank")
    expect(page).to have_field(:address_first, with: @address[:address_first])
    expect(page).to have_field(:address_second, with: @address[:address_second])
    expect(page).to have_field(:state, with: @address[:state])
    expect(page).to have_field(:zip, with: @address[:zip])
  end

  scenario 'My Shipping Information lets me view and edit my already added address' do
    address = create :address, user: current_user

    visit user_books_path
    click_link 'My Shipping Information'
    expect(current_path).to eq(user_account_path)
  end
end
