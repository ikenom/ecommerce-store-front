# frozen_string_literal: true

FactoryBot.define do
  factory :vendor do
    user { association :user }
    business_name { Faker::Company.name }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
