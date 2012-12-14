require 'spec_helper'

describe Gaku::Attendance do

  context "validations" do 
  	it { should belong_to(:attendance_type)}
  	it { should belong_to(:attendancable) }

  	it { should allow_mass_assignment_of :reason }

  end
end
