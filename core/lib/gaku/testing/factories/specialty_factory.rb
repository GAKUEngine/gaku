FactoryBot.define do
  factory :specialty, class: Gaku::Specialty do
    name 'Biology Specialty'
    description 'Biology Specialty Description'
    major_only 0

    factory :invalid_specialty do
      name nil
    end
  end
end
