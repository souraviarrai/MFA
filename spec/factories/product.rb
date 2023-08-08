# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    attachment { Faker::Avatar.image('image.jpg') }
    name { Faker::Name.name_with_middle }
    description { Faker::Lorem.word }
    price { Faker::Number.number(digits: 5) }
    quantity { Faker::Number.number(digits: 10) }
  end
end
