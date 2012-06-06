require 'spec_helper'

describe ExamScore do
  context "validations" do 
  	it { should have_valid_factory(:exam_score) }
    pending { should belong_to(:exam) }
    pending { should belong_to(:student) }
  end
end