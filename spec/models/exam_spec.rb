require 'spec_helper'

describe Exam do

  context "validations" do 
    it { should have_valid_factory(:exam) }
    it { should have_many(:exam_scores) }
    it { should have_many(:exam_portions) }
    it { should have_many(:exam_portion_scores) }
    it { should have_and_belong_to_many(:syllabuses) } 
    it { should belong_to(:schedule) }
  end
  
end