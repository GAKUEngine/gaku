require 'spec_helper'

describe Gaku::ExamPortion do
	
  context "validations" do 
  	let(:exam_portion) { create(:exam_portion) }
   
    it { should belong_to(:exam) }
    it { should belong_to(:grading_method) }

    it { should have_many(:exam_schedules) }
    it { should have_many(:exam_portion_scores) }
    it { should have_many(:attachments) }
    it { should have_many(:attendances) }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :max_score }
    it { should allow_mass_assignment_of :problem_count }
    it { should allow_mass_assignment_of :weight }
    it { should allow_mass_assignment_of :execution_date }
    it { should allow_mass_assignment_of :adjustments }

    it { should validate_presence_of :max_score }

    it { should validate_numericality_of(:max_score) }

    it "should validate max_score is greater than 0" do
      exam_portion.max_score = -1
      exam_portion.should be_invalid
    end

    it "should validate max_score is 0" do
      exam_portion.max_score = 0
      exam_portion.should be_valid
    end

    it "should validate weight is greater than 0" do
      exam_portion.weight = -1
      exam_portion.should be_invalid
    end

    it "should validate weight is 0" do
      exam_portion.weight = 0
      exam_portion.should be_valid
    end
  end

  context 'methods' do
    xit 'student_score'
  end

end
