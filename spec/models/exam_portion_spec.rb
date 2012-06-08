require 'spec_helper'

describe ExamPortion do
  context "validations" do 
    it { should have_valid_factory(:exam_portion) }
    it { should belong_to(:exam) }
  end
end