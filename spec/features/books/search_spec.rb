require 'rails_helper'

RSpec.describe 'Find books search feature' do
  before :each do
    @user = User.create!(first_name: 'Neal', last_name: 'Stephenson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit books_path
  end

  describe 'As a registered user' do
    it 'When I visit the find books page, I see a keyword search box' do
      # save_and_open_page
      within ".search-books" do
        expect(page.has_field? :search).to be_truthy
      end
    end

    xit 'When I fill in the text field with a book title and click the find books button, I am redirected to the books index where I see the results for my search' do
      within ".search-books" do
        fill_in :search, with: "Meditations"
        click_on "Find Books"
      end

      expect(current_path).to eq('/books')
      expect(page).to have_content("Meditations")
    end
  end
end
