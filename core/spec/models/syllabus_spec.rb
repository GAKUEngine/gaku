require 'spec_helper'

describe Syllabus do

  context "validations" do 
  	it { should have_valid_factory(:syllabus) }

    it { should have_many(:courses) }
    it { should have_many(:assignments) }
    it { should have_many(:exam_syllabuses) } 
    it { should have_many(:exams) } 
    it { should have_many(:lesson_plans) } 
  end
  
end
