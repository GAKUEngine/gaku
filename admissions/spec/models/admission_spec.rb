require 'spec_helper'

describe Gaku::Admission do

  context "validations" do 
    it { should belong_to :student } 
    it { should belong_to :scholarship_status }

    it { should have_many :specialty_applications }
    it { should have_many :admission_phase_records }
    it { should have_many :admission_methods }
    it { should have_many :notes }
  end
end
