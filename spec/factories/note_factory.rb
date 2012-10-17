FactoryGirl.define do
  factory :note do
    title "Excellent"
    content "Excellent student"
    association :notable, :factory => :student
  end
end
