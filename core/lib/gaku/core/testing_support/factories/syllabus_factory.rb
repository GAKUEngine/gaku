FactoryGirl.define do
  factory :syllabus, :class => Gaku::Syllabus do
    name { Faker::Name.name }
    code "12345"
    description "Short description"
    credits "Huge Credits"
  end
end
