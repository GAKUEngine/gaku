FactoryGirl.define do

  factory :class_group, :class => Gaku::ClassGroup do
    name "1A"
    grade 8
    homeroom "123"
  end


  trait :with_students do
    after_create do |resource|
      student1 = FactoryGirl.create(:student)
      student2 = FactoryGirl.create(:student)
      FactoryGirl.create(:class_group_enrollment, :student => student1, :class_group => resource)
      FactoryGirl.create(:class_group_enrollment, :student => student2, :class_group => resource)
    end
  end

  trait :with_semesters do
    after_create do |resource|
      2.times do
        resource.semesters << FactoryGirl.create(:semester)
      end
    end
  end


end
