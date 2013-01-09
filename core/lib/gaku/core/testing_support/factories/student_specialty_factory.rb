FactoryGirl.define do
  factory :student_specialty, :class => Gaku::StudentSpecialty do
    association(:student)
    association(:specialty)
    is_major 1
  end
end
