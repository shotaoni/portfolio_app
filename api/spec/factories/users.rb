# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'testuser' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    sequence(:uid, &:to_s)
  end
end
