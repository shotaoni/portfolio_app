FactoryBot.define do
  factory :user do
    name { "testuser" }
    email { "test1@sample.com" }
    uid { "1" }
    profile { "sample" }
  end
end
