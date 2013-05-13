FactoryGirl.define do
  factory :grading_method_set_item, :class => Gaku::GradingMethodSetItem do
    association(:grading_method_set)
    association(:grading_method)
  end
end
