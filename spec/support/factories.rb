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

  factory :author do
    first_name  Faker::Name.first_name
    last_name   Faker::Name.last_name
    description Faker::Lorem.paragraph(4)
  end

  factory :category do
    name Faker::Name.name
  end

  factory :country do
    name Faker::Address.country
  end

  factory :book do
    title             Faker::Lorem.word
    short_description Faker::Lorem.sentence(4)
    full_description  Faker::Lorem.paragraph(4)
    author
    category
    image             ''
    price             Faker::Number.number(3)

    factory :best_book do
      best_seller true
    end
  end

  factory :credit_card do
    number '12345678901234'
    cvv 111
    month 12
    year Time.now.year
    user
  end

  factory :state do
    state 'In progress'
  end

  factory :order do
    state
    user
  end

  factory :review do
    text Faker::Lorem.paragraph(4)
    number 10
    user
    book
    title Faker::Lorem.sentence(4)
  end

  factory :billing_address do
    address Faker::Address.street_address
    zipcode Faker::Address.zip
    city    Faker::Address.city
    phone   Faker::PhoneNumber.cell_phone
    country
    user
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
  end

  factory :shipping_address do
    address Faker::Address.street_address
    zipcode Faker::Address.zip
    city    Faker::Address.city
    phone   Faker::PhoneNumber.cell_phone
    country
    user
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
  end

  factory :order_item do
    quantity 1
    order
    book
    user
  end
end