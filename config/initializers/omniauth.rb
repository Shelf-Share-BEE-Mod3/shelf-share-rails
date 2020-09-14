# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV['GOOGLE_CLIENT_ID'],
           ENV['GOOGLE_CLIENT_SECRET'], {
             prompt: %w[select_account consent],
             access_type: 'offline',
             scope: %w[email profile books],
             skip_jwt: true
           }
end
