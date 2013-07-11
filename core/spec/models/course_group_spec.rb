require 'spec_helper'

describe Gaku::CourseGroup do

  describe 'associations' do
    it { should have_many :course_group_enrollments }
    it { should have_many(:courses).through(:course_group_enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

end
