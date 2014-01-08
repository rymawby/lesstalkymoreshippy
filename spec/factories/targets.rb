# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :target do
    name "MyString"
    project_id 1
    complete false
    target_date "2014-01-07"
  end
end
