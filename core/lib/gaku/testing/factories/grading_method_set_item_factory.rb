FactoryGirl.define do

  factory :grading_method_set_item, class: Gaku::GradingMethodSetItem do
    grading_method_set
    grading_method
  end

end
