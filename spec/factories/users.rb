FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) { |n| "user#{n}@awesome.com"}
    u.sequence(:phone_number) { |n| "+19999999#{n}"}
    u.sequence(:key) { |n| "#{n}"}
    u.sequence(:account_key) { |n| "#{n}"}
    u.full_name "John Doe"
    u.password "123456"
    u.metadata "metadata"
  end
end
