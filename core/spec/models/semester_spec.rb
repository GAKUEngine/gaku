require 'spec_helper'

describe Gaku::Semester do

  context "validations" do 
  	it { should belong_to(:class_group) }
    
    it { should allow_mass_assignment_of :starting }
    it { should allow_mass_assignment_of :ending }
    it { should allow_mass_assignment_of :class_group_id }

    xit 'uniqness of class group for semester'
    xit 'ending date is after starting'
  end
  
end
