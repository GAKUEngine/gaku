FactoryBot.define do
  factory :extracurricular_activity, class: Gaku::ExtracurricularActivity do
    sequence(:name) { |n| "tennis#{n}" }

    factory :invalid_extracurricular_activity do
      name nil
    end
  end
end
