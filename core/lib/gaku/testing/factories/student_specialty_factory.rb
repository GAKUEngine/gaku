FactoryBot.define do

  factory :student_specialty, class: Gaku::StudentSpecialty do
    student
    specialty
    major true

    factory :invalid_student_specialty do
      specialty nil
    end
  end

end
