FactoryGirl.define do

  factory :course, class: Gaku::Course do
    code  'A1'

    factory :invalid_course do
      code nil
    end
  end

end
