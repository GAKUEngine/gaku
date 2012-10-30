require 'spec_helper'

describe Gaku::ExamPortionScore do

  context "validations" do 
  	let(:exam_portion_score) { create(:exam_portion_score) }

    it { should have_valid_factory(:exam_portion_score) }
    it { should belong_to(:exam_portion) }
    it { should belong_to(:student)}  
  end  
end