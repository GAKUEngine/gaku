require 'spec_helper_models'

describe Gaku::CourseGroup, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :course_group_enrollments }
    it { is_expected.to have_many(:courses).through(:course_group_enrollments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#to_s' do
    let(:course_group) { build(:course_group) }

    specify { course_group.to_s.should eq course_group.name }
  end
end
