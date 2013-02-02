FactoryGirl.define do
  factory :simple_grade, :class => Gaku::SimpleGrade do
    name 'Math'
    grade 'A+'
    association(:school)
    association(:student)
    # need external_school_record factory
    # association(:external_school_record)
  end
end
