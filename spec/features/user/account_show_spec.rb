require 'rails_helper'

RSpec.describe 'Account Info Page' do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    Address.create!(
      address_first: '123 Main St',
      address_second: 'Unit 1',
      city: 'San Francisco',
      state: 'CA',
      zip: 90223,
      user_id: @user.id
    )
  end
  it 'displays users current address' do
    visit user_account_path

    expect(page).to have_content(@user.address.address_first)
    expect(page).to have_content(@user.address.address_second)
    expect(page).to have_content(@user.address.city)
    expect(page).to have_content(@user.address.state)
    expect(page).to have_content(@user.address.zip)
  end
  it 'has a link to update address' do
    updated = {
      address_first: '1984 Shelf Space',
      address_second: 'Unit 451',
      city: 'Castle Rock',
      state: 'ME',
      zip: '14101'
    }
    visit user_account_path

    expect(page).to have_link(edit_address_path)
    click_on "Update Address"
    expect(current_path).to eq(edit_address_path)

    fill_in :address_first, with: updated[:address_first]
    fill_in :address_second, with: updated[:address_second]
    fill_in :city, with: updated[:city]
    fill_in :state, with: updated[:state]
    fill_in :zip, with: updated[:zip]

    click_on 'Submit'

    expect(current_path).to eq(user_account_path)
    expect(page).to have_conten("Address updated successfully")
    expect(page).to have_content(updated[:address_first])
    expect(page).to have_content(updated[:address_second])
    expect(page).to have_content(updated[:city])
    expect(page).to have_content(updated[:state])
    expect(page).to have_content(updated[:zip])
  end
end
