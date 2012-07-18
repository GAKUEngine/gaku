require 'spec_helper'

describe Course do

  context "validations" do 
  	it { should have_valid_factory(:course) }
    it { should have_many(:students) }
    it { should have_many(:course_enrollments) }
    it { should belong_to(:syllabus) }
    it { should belong_to(:class_group) }
  end
  
end
