FactoryGirl.define do

  factory :class_group, class: Gaku::ClassGroup do
    name '1A'
    grade 8
    homeroom '123'

    factory :invalid_class_group do
      name nil
    end
  end

  trait :with_students do
    after(:create) do |resource|
      student1 = create(:student)
      student2 = create(:student)
      create(:class_group_enrollment, student: student1, class_group: resource)
      create(:class_group_enrollment, student: student2, class_group: resource)
    end
  end

end
