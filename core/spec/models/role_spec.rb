require 'spec_helper'

describe Gaku::Role do

  context "validations" do 
  	it { should belong_to(:class_group_enrollment) }
  	it { should belong_to(:faculty) }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :class_group_enrollment_id }
  end
  
end
