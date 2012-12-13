require 'spec_helper'

describe Gaku::AssignmentScore do

  context "validations" do
    it { should belong_to(:student) } 

    it "is invalid without a score" do 
      build(:assignment_score, score: nil).should_not be_valid
    end

    
  end
  
end
