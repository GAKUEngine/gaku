require 'spec_helper'

describe Assignment do

  context "validations" do 
  	it { should have_valid_factory(:assignment) }
  	it { should belong_to(:syllabus) }
  	it { should belong_to(:grading_method) }
  end
  
end
