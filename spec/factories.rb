FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password "passwordexample"
    password_confirmation "passwordexample"
  end
end