FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    description { Faker::Lorem.sentence }
    isbn { Faker::Code.isbn(base: 13).tr('-', '') }
    thumbnail { 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Indian_Election_Symbol_Book.svg' }
    category { Faker::Book.genre }
  end

  factory :user do
    faker_omniauth = Faker::Omniauth.new
    provider { 'google' }
    uid { Faker::Internet.uuid }
    email { faker_omniauth.email }
    first_name { faker_omniauth.first_name }
    last_name { faker_omniauth.last_name }
    token { 'TOKEN' }
    refresh_token { 'REFRESH_TOKEN' }
    oauth_expires_at { }
  end
end
