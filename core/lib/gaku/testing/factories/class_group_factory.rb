FactoryGirl.define do

  factory :class_group, class: Gaku::ClassGroup do
    sequence(:name) { |n| "A#{n}" }

    grade 8
    homeroom '123'

    factory :invalid_class_group do
      name nil
    end
  end

end
