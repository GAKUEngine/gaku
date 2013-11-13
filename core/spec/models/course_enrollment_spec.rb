require 'spec_helper_models'

describe Gaku::CourseEnrollment do

  describe 'associations' do
    it { should belong_to :course }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :course_id }
    it { should validate_presence_of :student_id }
    it { should validate_uniqueness_of(:student_id).scoped_to(:course_id).with_message(/Already enrolled to course!/) }
  end

end
