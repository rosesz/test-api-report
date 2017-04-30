FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "name#{n}" }
    sequence(:email)    { |n| "email#{n}@example.com" }
    password "password"
  end
end