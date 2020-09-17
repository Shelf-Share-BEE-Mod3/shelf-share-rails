require "rails_helper"

RSpec.describe "Address Prompt Page Spec" do
  before :each do
    @prompt = "Thank you for authorizing ShelfShare to manage your books! " +
              "ShelfShare is a platform for sharing books via mail. " +
              "You can borrow and lend books with your friends! " +
              "To participate fully in the shipping process, we kindly ask for your address. " +
              "Your address will be shown to other users when only when it is necessary to ship a book. " +
              "You can edit or delete your address at any time by visiting your profile."

    @disclaimer = "DISCLAIMER: " +
                  "The ShelfShare platform is a proof-of-concept and not likely to be maintained over time. " +
                  "Thus, any address information submitted will remain in our database indefinitely unless you delete it. " +
                  "For concerns regarding your privacy, please do not submit any real location information to this website."

    @message = 'You have already added an address. ' +
               'You can manage your address information from your profile page'
  end

  it "There is a prompt to add address when logging in" do
    login_as_user
    expect(current_path).to eq('/address/prompt')
    expect(page).to have_content(@prompt)
    expect(page).to have_content(@disclaimer)
    expect(page).to have_link("Add Address", href: new_address_path)
  end

  it "I can add my address from the address prompt page and I won't be prompted again" do
    address = build(:address, address_second: "Apt 101")

    login_as_user
    expect(current_path).to eq('/address/prompt')
    click_link("Add Address")
    expect(current_path).to eq(new_address_path)

    fill_in :address_first, with: address.address_first
    fill_in :address_second, with: address.address_second
    fill_in :city, with: address.city
    fill_in :state, with: address.state
    fill_in :zip, with: address.zip

    expect(current_user.address).to be_falsey
    click_button 'Submit Address'
    expect(page).to have_content('Address successfully saved')
    expect(current_user.address).to be_truthy

    visit root_path
    click_link "Logout"
    click_link 'Sign in with Google'

    expect(current_path).to eq(user_dashboard_path)

    visit '/address/prompt'
    expect(page).to_not have_content(@prompt)
    expect(page).to_not have_content(@disclaimer)
    expect(page).to have_content(@message)
    expect(page).to have_link('profile page')
  end

  it "If I have an address, I do not see the prompt when visiting the address prompt page" do
    user = create(:user)
    create(:address, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/address/prompt'
    expect(page).to_not have_content(@prompt)
    expect(page).to_not have_content(@disclaimer)
    expect(page).to have_content(@message)
    expect(page).to have_link('profile page')
  end
end
