require 'spec_helper'

describe Gaku::AdmissionPhaseRecord do

  context "validations" do 
    it "has a valid factory" do
      should have_valid_factory(:admission_phase_record) 
    end
  	it { should belong_to :admission }
  	it { should belong_to :admission_phase }
    it { should belong_to :admission_phase_state }

    it { should have_many :exam_scores }
    it { should have_many :notes }

  end
end