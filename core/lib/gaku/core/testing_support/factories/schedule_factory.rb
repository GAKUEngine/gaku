FactoryGirl.define do
  factory :schedule, :class => Gaku::Schedule do
    starting { Time.now }
    ending { starting + 40.minutes }
    repeat 3
  end
end
