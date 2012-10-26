FactoryGirl.define do
  factory :semester, :class => Gaku::Semester do
    starting { Time.now }
    ending { starting + 6.months }
  end
end
