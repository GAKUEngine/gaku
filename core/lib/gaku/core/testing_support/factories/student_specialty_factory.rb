FactoryGirl.define do

  factory :student_specialty, class: Gaku::StudentSpecialty do
    student
    specialty
    is_major 1
  end

end
