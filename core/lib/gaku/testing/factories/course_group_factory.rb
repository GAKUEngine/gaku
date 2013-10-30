FactoryGirl.define do

  factory :course_group, class: Gaku::CourseGroup do
    name  'Math Course Group'

    factory :invalid_course_group do
      name nil
    end
  end

end
