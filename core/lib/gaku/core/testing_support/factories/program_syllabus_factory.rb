FactoryGirl.define do
  factory :program_syllabus, :class => Gaku::ProgramSyllabus do
    association(:program)
    association(:syllabus)
  end
end
