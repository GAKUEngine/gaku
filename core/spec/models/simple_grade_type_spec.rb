require 'spec_helper_models'

describe Gaku::SimpleGradeType, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :school }
    it { is_expected.to belong_to :grading_method }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#to_s' do
    let(:simple_grade_type) { build(:simple_grade_type) }

    specify { simple_grade_type.to_s.should eq simple_grade_type.name }
  end
end
