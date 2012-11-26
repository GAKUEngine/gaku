require 'spec_helper'

describe Gaku::CourseEnrollment do

  context "validations" do 
    it { should have_valid_factory(:course_enrollment) }
    it { should belong_to(:course) }
    it { should belong_to(:student) }
  end
  
end
