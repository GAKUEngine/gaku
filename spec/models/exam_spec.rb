require 'spec_helper'

describe Exam do

  context "validations" do 
  	let(:exam) { stub_model(Exam) }

    it { should have_valid_factory(:exam) }
    it { should have_many(:exam_scores) }
    it { should have_many(:exam_portions) }
    it { should have_many(:exam_portion_scores) }
    it { should have_and_belong_to_many(:syllabuses) } 
    it { should belong_to(:schedule) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:max_score) }

    it "errors when name is nil" do
      exam.name = nil
      exam.should_not be_valid
    end

    it "errors when smax_score is nil" do
      exam.max_score = nil
      exam.should_not be_valid
    end
  end
  
end