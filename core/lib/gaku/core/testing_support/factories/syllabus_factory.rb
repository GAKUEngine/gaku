FactoryGirl.define do
  factory :syllabus do
    name { Faker::Name.name }
    code "12345"
    description "Short description"
    credits "Huge Credits"
  end
end
