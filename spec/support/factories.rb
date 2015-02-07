

FactoryGirl.define do

  factory :user do
    email      Faker::Internet.email
    password   Faker::Internet.password(8)
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name

    factory :admin do
      admin true
    end
  end

  factory :book do
    title             Faker::Lorem.word
    short_description Faker::Lorem.sentence(4)
    full_description  Faker::Lorem.paragraph(4)
    author
    category
    image             Faker::Avatar.image
    price             Faker::Number.number(3)
  end

  factory :author do
    first_name  Faker::Name.first_name
    last_name   Faker::Name.last_name
    description Faker::Lorem.paragraph(4)
  end

  factory :category do
    name Faker::Name.name
  end

  factory :rating do
    review Faker::Lorem.paragraph(4)
    number 1
    user
    book
  end
end