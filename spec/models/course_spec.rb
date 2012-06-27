require 'spec_helper'

describe Course do

  context "validations" do 
  	it { should have_valid_factory(:course) }
    it { should have_many(:students) }
    it { should have_many(:course_enrollments) }
    it { should have_one(:syllabus) }
  end
  
end
