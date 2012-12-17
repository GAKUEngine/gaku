require 'spec_helper'

describe Gaku::SchoolHistory do

  context "validations" do 
  	it { should belong_to :school }
  	it { should belong_to :student }

    it { should allow_mass_assignment_of :school_id }
    it { should allow_mass_assignment_of :student_id }
  end
end
