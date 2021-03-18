# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    auth_id { Faker::Alphanumeric.alpha }
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name  }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end
