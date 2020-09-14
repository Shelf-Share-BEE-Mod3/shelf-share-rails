FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    description { Faker::Lorem.sentence }
    isbn { Faker::Code.isbn }
    thumbnail { 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Indian_Election_Symbol_Book.svg' }
    category { Faker::Book.genre }
  end
end
