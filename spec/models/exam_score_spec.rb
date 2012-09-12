require 'spec_helper'

describe ExamScore do

  context "validations" do 
  	let(:exam_score) { Factory(:exam_score) }

  	it { should have_valid_factory(:exam_score) }
    it { should belong_to(:exam) }

    it { should validate_presence_of(:score) }

    it "errors when score is nil" do
      exam_score.score = nil
      exam_score.should_not be_valid
    end

    it "should validate score is greater than 0" do
      exam_score.score = -1
      exam_score.should be_invalid
    end

    it "should validate score is 0" do
      exam_score.score = 0
      exam_score.should be_valid
    end
  end
  
end
