FactoryGirl.define do
  factory :program_specialty, :class => Gaku::ProgramSpecialty do
    association(:program)
    association(:specialty)
  end
end
