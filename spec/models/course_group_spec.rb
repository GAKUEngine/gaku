require 'spec_helper'

describe CourseGroup do

  context "validations" do 
  	it { should have_valid_factory(:course_group) }
    it { should have_many(:course_group_enrollments) }
    it { should have_many(:courses) }

    it { should allow_mass_assignment_of(:name) }
  end
end
