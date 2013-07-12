FactoryGirl.define do
  factory :program_level, class: Gaku::ProgramLevel do
    association :program
    association :level
  end
end
