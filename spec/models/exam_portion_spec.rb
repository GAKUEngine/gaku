require 'spec_helper'

describe ExamPortion do
	
  context "validations" do 
    it { should have_valid_factory(:exam_portion) }
    it { should belong_to(:exam) }
    it { should have_many(:exam_portion_scores) }
    it { should belong_to(:schedule) }
  end

end