require 'spec_helper'

describe Gaku::AdmissionPhase do

  context "validations" do 

    it "has a valid factory" do
      should have_valid_factory(:admission_phase) 
    end

    it { should belong_to :admission_method }

  	it { should have_many :admission_phase_records }
    it { should have_many :exams }
  	it { should have_many :admission_phase_states }

  end
end