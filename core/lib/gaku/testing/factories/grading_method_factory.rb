FactoryGirl.define do

  factory :grading_method, class: Gaku::GradingMethod do
    sequence(:name) { |n | "Method #{n}" }
    description 'this method is '
    method 'method'

    factory :invalid_grading_method do
      name nil
    end
  end

end
