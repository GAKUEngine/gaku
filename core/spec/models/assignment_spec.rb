require 'spec_helper_models'

describe Gaku::Assignment, type: :model do

  describe 'relations' do
    it { should belong_to :syllabus }
    it { should belong_to :grading_method }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:assignment) { build(:assignment) }
    specify { assignment.to_s.should eq assignment.name }
  end

end
