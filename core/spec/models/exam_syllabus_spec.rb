require 'spec_helper'

describe Gaku::ExamSyllabus do

  context "validations" do 
    it { should belong_to(:exam) }
    it { should belong_to(:syllabus) }

    it { should validate_presence_of :exam_id }
    it { should validate_presence_of :syllabus_id }

    it { should validate_uniqueness_of(:syllabus_id).scoped_to(:exam_id).with_message(/Already added exam to syllabus!/) }
    
    it { should allow_mass_assignment_of :exam_id }
  end
  
end
