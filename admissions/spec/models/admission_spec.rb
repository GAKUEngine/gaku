require 'spec_helper'

describe Gaku::Admission do

  context "validations" do 
    it { should belong_to :student } 
    it { should have_many :admission_phase_records }
  end
end
