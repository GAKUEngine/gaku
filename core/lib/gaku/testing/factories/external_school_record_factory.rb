FactoryBot.define do
  factory :external_school_record, class: Gaku::ExternalSchoolRecord do
    beginning { Time.now - 1.year }
    ending { Time.now }
    school
    student

    factory :invalid_external_school_record do
      school { nil }
    end
  end
end
