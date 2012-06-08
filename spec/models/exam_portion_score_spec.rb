require 'spec_helper'

describe ExamPortionScore do
  context "validations" do 
    it { should have_valid_factory(:exam_portion_score) }
  end
end