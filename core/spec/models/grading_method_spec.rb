require 'spec_helper'

describe Gaku::GradingMethod do

  context "validations" do 
  	it { should have_one(:exam) }
  	it { should have_one(:exam_portion) }
  	it { should have_one(:assignment) }

    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :method }
    it { should allow_mass_assignment_of :name }
  end
  
end
