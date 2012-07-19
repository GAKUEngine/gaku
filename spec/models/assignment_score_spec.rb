require 'spec_helper'

describe AssignmentScore do

  context "validations" do 
  	it { should have_valid_factory(:assignment_score) }
  	it { should belong_to(:student) } 
  end
  
end