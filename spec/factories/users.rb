# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :user_email do |n|
    domain = ['yahoo', 'gmail', 'rediffmail'].sample
    "email#{n}@#{domain}.com"
  end

  factory :user do
    email { FactoryGirl.generate(:user_email) }
    password "Password!123"
  end
end
