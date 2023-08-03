# frozen_string_literal: true

FactoryBot.define do
  factory :outlet do
    name { Faker::Games::DnD.city }
    user_id { Faker::IDNumber.valid }
  end
end
