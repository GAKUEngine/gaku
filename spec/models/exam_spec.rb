require 'spec_helper'

describe Exam do

  context "validations" do 
  	let(:exam) { Factory(:exam) }

    it { should have_valid_factory(:exam) }
    it { should have_many(:exam_scores) }
    it { should have_many(:exam_portions) }
    it { should have_many(:exam_portion_scores) }
    it { should have_and_belong_to_many(:syllabuses) } 

    it { should validate_presence_of(:name) }

    it "errors when name is nil" do
      exam.name = nil
      exam.should_not be_valid
    end

    it "should validate weight is greater than 0" do
      exam.weight = -1
      exam.should be_invalid
    end

    it "should validate weight is 0" do
      exam.weight = 0
      exam.should be_valid
    end
  end

  context "master exam portion" do
    it "should always have a master exam portion" do
      exam = Exam.new
      exam.master.should_not be_nil
    end
  end
  
end