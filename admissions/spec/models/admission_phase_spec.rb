require 'spec_helper'

describe Gaku::AdmissionPhase do

  context "validations" do 
  	it { should have_many :admission_phase_records }
  end
end
