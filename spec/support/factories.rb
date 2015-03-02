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
    image             ''
    price             Faker::Number.number(3)

    factory :best_book do
      best_seller true
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
    total_price nil
    completed_date nil
    state
    user
    visitor_id nil
    delivery 5
  end

  factory :review do
    text Faker::Lorem.paragraph(4)
    number 10
    user
    book
    visitor_id nil
    title Faker::Lorem.sentence(4)
  end

  #factory :billing_address do
    #address
   # zipcode
    #city
 # end
end