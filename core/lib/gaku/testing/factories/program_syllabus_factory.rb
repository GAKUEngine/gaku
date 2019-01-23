FactoryBot.define do

  factory :program_syllabus, class: Gaku::ProgramSyllabus do
    program
    syllabus
    level
  end

end
