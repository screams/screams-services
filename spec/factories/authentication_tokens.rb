# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication_token do
    token "MyString"
    expires false
    generated_at "2014-07-03 19:30:03"
    user { FactoryGirl.create(:user) }
  end
end
