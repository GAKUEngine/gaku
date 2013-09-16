FactoryGirl.define do

  factory :grading_method_set_item, class: Gaku::GradingMethodSetItem do
    grading_method_set
    grading_method

    factory :invalid_grading_method_set_item do
      grading_method nil
    end
  end

end
