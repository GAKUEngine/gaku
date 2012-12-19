require 'spec_helper'

describe Gaku::AttendanceType do

  context "validations" do 
  	it { should have_many(:attendances)}

    it { should validate_presence_of(:name) }
  	
  	it { should allow_mass_assignment_of :name }
  	it { should allow_mass_assignment_of :color_code }
  	it { should allow_mass_assignment_of :counted_absent }
  	it { should allow_mass_assignment_of :disable_credit }
  	it { should allow_mass_assignment_of :credit_rate }
  	it { should allow_mass_assignment_of :auto_credit}

  end
end
