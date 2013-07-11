require 'spec_helper'

describe Gaku::SemesterCourse do

  describe 'associations' do
    it { should belong_to :semester }
    it { should belong_to :course }
  end

  describe 'validations' do
    it { should validate_presence_of :semester_id }
    it { should validate_presence_of :course_id }

    it { should validate_uniqueness_of(:semester_id).scoped_to(:course_id).with_message(/Semester already added to Course/) }
  end

end
