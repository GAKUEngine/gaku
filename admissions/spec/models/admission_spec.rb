require 'spec_helper'

describe Gaku::Admission do

  context "validations" do
    it { should belong_to :student } 
    it { should belong_to :scholarship_status }
    it { should belong_to :admission_method }
    it { should belong_to :admission_period}

    it { should have_many :specialty_applications }
    it { should have_many :admission_phase_records }
    it { should have_many(:exam_scores).through(:admission_phase_records) }
    it { should have_many :attachments }
    it { should have_many :notes }

    it { should have_one :external_school_record }

    it { should accept_nested_attributes_for :student }
    it { should accept_nested_attributes_for(:admission_phase_records).allow_destroy(true) }

    it { should allow_mass_assignment_of :student_id }
    it { should allow_mass_assignment_of :scholarship_status_id }
    it { should allow_mass_assignment_of :admission_method_id }
    it { should allow_mass_assignment_of :admission_period_id }
    it { should allow_mass_assignment_of :student_attributes }    
  end
end