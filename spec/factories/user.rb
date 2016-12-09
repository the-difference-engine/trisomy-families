FactoryGirl.define do
  factory :user do
    email 'test2@email.com'
    password 'password'
  end

  factory :admin do
    email 'test3@email.com'
    password 'password'
  end
end