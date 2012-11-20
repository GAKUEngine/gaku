require 'spec_helper'

describe Gaku::AdmissionPhase do

  context "validations" do 

    it { should belong_to :admission_method }

  	it { should have_many :admission_phase_records }
    #it { should have_many :exams }
  	it { should have_many :admission_phase_states }

  end
end