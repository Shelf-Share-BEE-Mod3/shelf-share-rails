module SessionHelpers

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: "lito@gmail.com",
        first_name: "Lito",
        last_name: "White"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: "063021",
      }
    })
  end

  def login_as_user
    expect do
      stub_omniauth
      visit root_path
      expect(page).to have_link("Sign in with Google")
      click_link "Sign in with Google"
    end.to change { User.count }.by(1)
  end

  def current_user
    User.find_by(email: 'lito@gmail.com')
  end
end

RSpec.configure do |config|
  config.include SessionHelpers, type: :feature
end
