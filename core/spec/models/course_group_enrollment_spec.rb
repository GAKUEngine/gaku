require 'spec_helper_models'

describe Gaku::CourseGroupEnrollment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :course_group }
    it { is_expected.to belong_to :course }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :course_group_id }
    it { is_expected.to validate_presence_of :course_id }
    it do
      expect(subject).to validate_uniqueness_of(:course_id).scoped_to(:course_group_id)
                                                           .with_message(/Already enrolled to this course group!/)
    end
  end
end
