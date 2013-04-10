FactoryGirl.define do
  factory :semester_class_group, :class => Gaku::SemesterClassGroup do
    association(:semester)
    association(:class_group)
  end
end
