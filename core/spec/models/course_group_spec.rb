require 'spec_helper'

describe Gaku::CourseGroup do

  context "validations" do 
    it { should have_many(:course_group_enrollments) }
    it { should have_many(:courses).through(:course_group_enrollments) }

    it { should validate_presence_of :name }
    
    it { should allow_mass_assignment_of(:name) }
  end
end
