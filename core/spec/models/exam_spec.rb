require 'spec_helper'

describe Gaku::Exam do

  context "validations" do 
  	let(:exam) { create(:exam) }

    it { should have_many :exam_scores }
    it { should have_many :exam_portions }
    it { should have_many(:exam_portion_scores).through(:exam_portions) }
    it { should have_many :exam_syllabuses } 
    it { should have_many(:syllabuses).through(:exam_syllabuses) } 
    it { should have_many :notes }
    it { should have_many :attendances } 

    it { should belong_to :grading_method }
    
    it { should validate_presence_of(:name) }

    it { should validate_numericality_of(:weight) }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :weight }
    it { should allow_mass_assignment_of :use_weighting }
    it { should allow_mass_assignment_of :is_standalone }
    it { should allow_mass_assignment_of :adjustments }
    it { should allow_mass_assignment_of :exam_portions_attributes }
    it { should allow_mass_assignment_of :grading_method_id }

    it { should accept_nested_attributes_for :exam_portions }


    it "errors when name is nil" do
      exam.name = nil
      exam.should_not be_valid
    end

    it "should validate weight is greater than 0" do
      exam.weight = -1
      exam.should be_invalid
    end

    it "should validate weight is 0" do
      exam.weight = 0
      exam.should be_valid
    end
  end

  context 'methods' do
    xit 'total_weight'
    xit 'max_score'
  end
  
end
