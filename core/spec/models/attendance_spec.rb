require 'spec_helper'

describe Gaku::Attendance do

  context "validations" do 
  	it { should have_valid_factory(:attendance) }

  	it { should belong_to(:attendancable) }

  	it { should allow_mass_assignment_of :reason }
  	it { should allow_mass_assignment_of :description }

  end
end
