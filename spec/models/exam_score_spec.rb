require 'spec_helper'

describe ExamScore do
  context "validations" do 
  	it { should have_valid_factory(:exam_score) }
    it { should belong_to(:exam) }
  end
end