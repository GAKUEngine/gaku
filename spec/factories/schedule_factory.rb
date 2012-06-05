FactoryGirl.define do
  factory :schedule do
    start { Time.now }
    stop { start + 40.minutes }
    repeat 3
  end
end