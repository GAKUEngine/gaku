require 'spec_helper'

describe ExamPortionScore do
  context "validations" do 
    it { should have_valid_factory(:exam_portion_score) }
    it { should belong_to(:exam_portion) }
  end
end