# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Games::DnD.city }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { 'admin' }
    auth_token { Faker::Internet.device_token }
  end
end
