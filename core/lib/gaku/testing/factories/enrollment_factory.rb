%w( class_group course extracurricular_activity ).each do |resource|
  FactoryGirl.define do

    factory "#{resource}_enrollment", class: Gaku::Enrollment do
      student
      association :enrollable, factory: resource
    end

  end
end
