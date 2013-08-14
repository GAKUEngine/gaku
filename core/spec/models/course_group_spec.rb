require 'spec_helper'

describe Gaku::CourseGroup do

  describe 'concerns' do
    it_behaves_like 'thrashable'
  end

  describe 'associations' do
    it { should have_many :course_group_enrollments }
    it { should have_many(:courses).through(:course_group_enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:course_group) { build(:course_group) }
    specify { course_group.to_s.should eq course_group.name }
  end

end
