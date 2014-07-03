# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scream do
    text "Scream text"
    private_scream false
    user nil
  end
end
