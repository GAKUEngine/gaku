require 'spec_helper_models'

describe Gaku::CourseGroupEnrollment do

  describe 'associations' do
    it { should belong_to :course_group }
    it { should belong_to :course }
  end

  describe 'validations' do
    it { should validate_presence_of :course_group_id }
    it { should validate_presence_of :course_id }
    it { should validate_uniqueness_of(:course_id).scoped_to(:course_group_id).with_message(/Already enrolled to this course group!/) }
  end

end
