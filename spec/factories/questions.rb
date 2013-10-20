# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    body                  { Faker::Lorem.paragraph }
    # figure out how to add four answers -- may like so:
    # after(:create) { |q|
    #   4.repeat { q.answers.build(:body => "blah") }
    # }
  end
end
