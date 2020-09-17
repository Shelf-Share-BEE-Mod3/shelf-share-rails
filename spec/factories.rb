FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    description { Faker::Lorem.sentence }
    isbn { Faker::Code.isbn(base: 13).tr('-', '') }
    thumbnail { 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Indian_Election_Symbol_Book.svg' }
    category { Faker::Book.genre }
  end

  factory :user, aliases: [:borrower, :friend] do
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

  factory :user_book do
    user
    book
    status { 'available' }
  end

  factory :borrow_request, aliases: [:request] do
    borrower
    user_book
    status { 'pending' }
  end

  factory :address do
    user
    address_first { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end
end
