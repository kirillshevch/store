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

  factory :books do
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

  factory :categories do
    name Faker::Name.name
  end

  factory :rating do
    review Faker::Lorem.paragraph(4)
    number 1
    user
    book
  end

  factory :country do
    name Faker::Address.country
  end

  factory :credit_card do
    number 1111111111111111
    cvv 111
    month 12
    year Time.now.year
    user
  end
end