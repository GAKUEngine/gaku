FactoryGirl.define do
  factory :note do
    title "Excellent"
    content "Excellent student"
    association :student
  end
end
