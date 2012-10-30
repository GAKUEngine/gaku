require 'spec_helper'

describe Gaku::AdmissionPhaseRecord do

  context "validations" do 
  	it { should belong_to :admission }
  	it { should belong_to :admission_phase }
  end
end
