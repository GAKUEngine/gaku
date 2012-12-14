require 'spec_helper'

describe Gaku::Admission do

  context "validations" do
    it { should belong_to :student } 
    it { should belong_to :scholarship_status }
    it { should belong_to :admission_method }
    it { should belong_to :admission_period}

    it { should have_many :specialty_applications }
    it { should have_many :admission_phase_records }
    #it { should have_many :exam_scores }
    it { should have_many :attachments }
    it { should have_many :notes }

    #it { should have_one :school_history }
  end
end