FactoryGirl.define do

  factory :program_specialty, class: Gaku::ProgramSpecialty do
    program
    specialty
  end

end
