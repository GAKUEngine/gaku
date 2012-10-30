require 'spec_helper'

describe Gaku::ExamSyllabus do

  context "validations" do 
    it { should belong_to(:exam) }
    it { should belong_to(:syllabus) }
  end
  
end
