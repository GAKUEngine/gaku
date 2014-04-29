FactoryGirl.define do

  factory :grading_method, class: Gaku::GradingMethod do
    sequence(:name) { |n | "Method #{n}" }
<<<<<<< HEAD
    method 'score'
    description 'Grading method description'
=======
    description 'this method is '
    method 'method'
>>>>>>> master

    factory :invalid_grading_method do
      name nil
    end
  end

end
