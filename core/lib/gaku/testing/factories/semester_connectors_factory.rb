#add assigments when integrate with GradingMethodConnector
%w( class_group course ).each do |resource|
  FactoryGirl.define do

    factory "semester_connector_#{resource}", class: Gaku::SemesterConnector do
      semester
      association :semesterable, factory: resource
    end

  end
end
