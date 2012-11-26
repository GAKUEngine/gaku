FactoryGirl.define do
  factory :note, :class => Gaku::Note do
    title "Excellent"
    content "Excellent student"
    association :notable, :factory => :student
  end
end
