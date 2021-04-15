# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'MyString' }
    point { 'test' }
    association :user
  end
end
