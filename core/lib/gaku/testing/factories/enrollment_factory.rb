%w( class_group course extracurricular_activity ).each do |resource|
  FactoryGirl.define do

    factory "#{resource}_enrollment", class: Gaku::Enrollment do
      student
      association :enrollmentable, factory: resource
    end

  end
end
