require 'spec_helper'

describe Gaku::AdmissionPhaseState do

  context "validations" do 
    it "has a valid factory" do
      should have_valid_factory(:admission_phase_state) 
    end
  	it { should belong_to :admission_phase }
  end
end
