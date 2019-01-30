# add assigments when integrate with GradingMethodConnector
%w[exam course].each do |resource|
  FactoryBot.define do
    factory "grading_method_connector_#{resource}", class: Gaku::GradingMethodConnector do
      grading_method
      association :gradable, factory: resource
    end
  end
end
