require 'spec_helper'

describe Gaku::ExamPortionScore do

  context "validations" do 
  	let(:exam_portion_score) { create(:exam_portion_score) }

    it { should belong_to :exam_portion }
    it { should belong_to :student }  

    it { should have_many :attendances }

    it { should allow_mass_assignment_of :score }
    it { should allow_mass_assignment_of :exam_portion_id }
    it { should allow_mass_assignment_of :student_id }
  end  
end