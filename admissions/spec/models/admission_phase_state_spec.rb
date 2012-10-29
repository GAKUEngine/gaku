require 'spec_helper'

describe Gaku::AdmissionPhaseState do

  context "validations" do 
  	it { should belong_to :admission_phase }
  end
end
