# frozen_string_literal: true

FactoryBot.define do
  factory :outlet do
    name { Faker::Games::DnD.city }
    user { User.take || build(:user) }
    location {Faker::Games::DnD.city}
    status { 'accepted' }
  end
end
