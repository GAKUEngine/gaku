require 'spec_helper'

module Gaku
  describe SemesterCourse do
    context "validations" do

      it { should belong_to :semester }
      it { should belong_to :course }

      it { should validate_presence_of :semester_id }
      it { should validate_presence_of :course_id }

    end
  end
end
