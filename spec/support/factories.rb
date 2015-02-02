FactoryGirl.define do

  factory :user do
    email      Faker::Internet.email
    password   Faker::Internet.password(8)
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
  end

  factory :book do
    title             Faker::Lorem.word
    short_description Faker::Lorem.sentence(4)
    full_description  Faker::Lorem.paragraph(10)
    author
    category
    image             Faker::Avatar.image
    price             Faker::Number.number(3)
  end

  factory :author do
    first_name  Faker::Name.first_name
    last_name   Faker::Name.last_name
    description Faker::Lorem.paragraph(10)
  end

  factory :category do
    name Faker::Name.name
  end
end