require "rails_helper"

RSpec.describe "Dashboard Page Scaffold" do
  it 'Exists' do
    login_as_user
    visit user_dashboard_path

    expect(page).to have_css(".book-requests")
    expect(page).to have_css(".borrowed-books")
    expect(page).to have_css(".loaned-books")
    expect(page).to have_css(".friend-requests")
  end
end
