FactoryGirl.define do
  factory :semester do
    starting { Time.now }
    ending { starting + 6.months }
  end
end
