FactoryGirl.define do
  factory :grading_method, :class => Gaku::GradingMethod do
    name "Method 1"
    method "Method"
    description "Grading method description"
  end
end
