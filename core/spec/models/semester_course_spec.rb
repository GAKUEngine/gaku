require 'spec_helper'

module Gaku
  describe SemesterCourse do
    context "validations" do

      it { should belong_to :semester }
      it { should belong_to :course }

      it { should validate_presence_of :semester_id }
      it { should validate_presence_of :course_id }

      it { should allow_mass_assignment_of :semester_id }
      it { should allow_mass_assignment_of :course_id }

      it { should validate_uniqueness_of(:semester_id).scoped_to(:course_id).with_message(/Semester already added to Course/) }

    end
  end
end
