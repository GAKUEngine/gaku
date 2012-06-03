require 'spec_helper'

describe ExamScore do
  context "validations" do 
    it { should belong_to(:exam) }
    it { should belong_to(:student) }
  end
end