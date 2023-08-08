# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user_id { Faker::IDNumber.valid }
    product_id { Faker::IDNumber.valid }
    outlet_id { Faker::IDNumber.valid }
    quantity { Faker::Number.number(digits: 10) }
  end
end
