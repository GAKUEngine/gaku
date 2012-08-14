# == Schema Information
#
# Table name: exam_portion_scores
#
#  id              :integer          not null, primary key
#  score           :float
#  exam_portion_id :integer
#  student_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe ExamPortionScore do

  context "validations" do 
  	let(:exam_portion_score) { Factory(:exam_portion_score) }

    it { should have_valid_factory(:exam_portion_score) }
    it { should belong_to(:exam_portion) }
    it { should belong_to(:student)}
    #it { should validate_presence_of(:score) }

    pending "errors when score is nil" do
      exam_portion_score.score = nil
      exam_portion_score.should_not be_valid
    end

    pending "should validate score is greater than 0" do
      exam_portion_score.score = -1
      exam_portion_score.should be_invalid
    end

    pending "should validate score is 0" do
      exam_portion_score.score = 0
      exam_portion_score.should be_valid
    end
  end
  
end
