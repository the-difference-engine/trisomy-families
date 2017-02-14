FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@factory.com" }
    # email 'test7@email.com'
    password 'password'
    first_name 'haha'
    last_name 'clinton'
    phone_number '6306408224'
    city 'chicago'
    state 'Illinois'
  end

  factory :admin do
    email 'test3@email.com'
    password 'password'
  end
end
