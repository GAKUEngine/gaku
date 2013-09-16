FactoryGirl.define do

  factory :grading_method, class: Gaku::GradingMethod do
    sequence(:name) { |n | "Method #{n}" }
    method 'Method'
    description 'Grading method description'

    factory :invalid_grading_method do
      name nil
    end
  end

end
