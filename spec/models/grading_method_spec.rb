require 'spec_helper'

describe GradingMethod do

  context "validations" do 
  	it { should have_valid_factory(:grading_method) }
  	it { should have_one(:exam) }
  	it { should have_one(:exam_portion) }
  	it { should have_one(:assignment) }
  end
  
end