FactoryGirl.define do

  factory :semester_class_group, class: Gaku::SemesterClassGroup do
    semester
    class_group
  end

end
