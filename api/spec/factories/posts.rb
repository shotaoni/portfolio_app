# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'MyString' }
    user { nil }
  end
end
