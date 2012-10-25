FactoryGirl.define do
  factory :schedule do
    starting { Time.now }
    ending { starting + 40.minutes }
    repeat 3
  end
end
