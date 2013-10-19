# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    username              { Faker::Internet.user_name }
    password              "changeme"
    password_confirmation "changeme"
  end
end