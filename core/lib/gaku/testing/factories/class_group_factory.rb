FactoryBot.define do

  factory :class_group, class: Gaku::ClassGroup do
    sequence(:name) { |n| "A#{n}" }

    grade 8
    homeroom '123'

    factory :invalid_class_group do
      name nil
    end

    factory :class_group_with_active_semester do
      transient do
        semester { create(:active_semester) }
      end

      after(:create) do |class_group, evaluator|
        class_group.semesters << evaluator.semester
      end
    end
  end

end
