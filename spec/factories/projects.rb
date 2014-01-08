# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    creator_id 1
    validator_id 1
    title "MyString"
    description "MyString"
  end
end
