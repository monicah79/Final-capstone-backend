require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :reservation do
    user
  end

  factory :laptop_reservation do
    laptop
    reservation
    city { 'New York' }
    quantity { 1 }
  end

  factory :laptop do
    name { 'MacBook Pro' }
    price { 1299.99 }
    cpu { 'Intel Core i7' }
    memory { 16 }
    storage { 512 }
    association :user
  end
end
