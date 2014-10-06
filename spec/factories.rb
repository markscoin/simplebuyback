FactoryGirl.define do
  factory :user do
    email "testuser@example.com"
    password "passwordexample"
    password_confirmation "passwordexample"
  end
  
  factory :order, :class => Spree::Order do
    association(:user, :factory => :user)
    completed_at "1/1/2014"
    id 200
    number "1000"
    item_count 1
    total 9.99
  end
end