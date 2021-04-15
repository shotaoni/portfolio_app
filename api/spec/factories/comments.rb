# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    association :post
    association :user
  end
end
