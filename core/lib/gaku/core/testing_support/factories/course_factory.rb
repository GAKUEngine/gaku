FactoryGirl.define do
  factory :course, :class => Gaku::Course do
    #association(:syllabus)
    code  "A1"
  end
end
