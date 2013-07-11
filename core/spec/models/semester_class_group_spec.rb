require 'spec_helper'

describe Gaku::SemesterClassGroup do

  describe 'associations' do
    it { should belong_to :semester }
    it { should belong_to :class_group }
  end

  describe 'validations' do
    it { should validate_presence_of :semester_id }
    it { should validate_presence_of :class_group_id }

    it { should validate_uniqueness_of(:semester_id).scoped_to(:class_group_id).with_message(/Semester already added to Class Group/) }
  end

end
