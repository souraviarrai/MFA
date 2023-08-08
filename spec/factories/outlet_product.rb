# frozen_string_literal: true

FactoryBot.define do
  factory :outlet_product do
    outlet_id { Faker::IDNumber.valid }
    product_id { Faker::IDNumber.valid }
  end
end
