FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@factory.com" }
    # email 'test7@email.com'
    password 'password'
  end

  factory :admin do
    email 'test3@email.com'
    password 'password'
  end
end
