require 'spec_helper'

describe Gaku::AdmissionPhase do

  context "validations" do

    it { should belong_to :admission_method }

  	it { should have_many :admission_phase_records }
    it { should have_one :exam }
  	it { should have_many :admission_phase_states }

    it { should validate_presence_of :admission_method }
    it { should validate_presence_of :name }

  end

  context 'methods' do
    xit 'proper_position'
    xit 'refresh_positions'
    xit 'find next phase'
  end
end