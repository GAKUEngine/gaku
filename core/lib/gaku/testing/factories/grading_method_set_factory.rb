FactoryBot.define do
  factory :grading_method_set, class: Gaku::GradingMethodSet do
    sequence(:name) { |n| "Set #{n}" }

    factory :invalid_grading_method_set do
      name { nil }
    end
  end
end
