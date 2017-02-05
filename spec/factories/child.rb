FactoryGirl.define do
  factory :child do
    first_name 'David'
    last_name 'Williams'
    trisomy_type '1'
    state 'IL'
    city 'Chicago'
    trisomy_story 'Lorem'
    birth_date '2017-01-01'
    nickname 'Ipsom'
    birth_order '1'
    primary_diagnosis 'Full'
    other_primary_diagnosis 'B'

    factory :child_with_privacy do
      transient do
        privacy_count 1
      end
      after(:create) do |child, evaluator|
        create_list(:privacy, evaluator.privacy_count, child: child)
      end
    end
  end
end
