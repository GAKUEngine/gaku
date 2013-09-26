FactoryGirl.define do

  factory :student_specialty, class: Gaku::StudentSpecialty do
    student
    specialty
    major true
  end

end
