require 'spec_helper'

describe Gaku::AdmissionPhaseRecord do

  context "validations" do 
    
  	it { should belong_to :admission }
  	it { should belong_to :admission_phase }
    it { should belong_to :admission_phase_state }

    it { should have_many :exam_scores }
    it { should have_many :notes }

  end
end