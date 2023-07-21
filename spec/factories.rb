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
end
