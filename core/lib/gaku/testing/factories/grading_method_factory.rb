FactoryBot.define do

  factory :grading_method, class: Gaku::GradingMethod do
    sequence(:name) { |n| "Method #{n}" }
    description 'Grading method description'

    grading_type 'score'

    factory :invalid_grading_method do
      name nil
    end
  end

end
