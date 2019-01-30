require 'spec_helper_models'

describe Gaku::AssignmentScore, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :student }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :score }
    it { is_expected.to validate_presence_of :student }
  end

  describe '#to_s' do
    let(:assignment_score) { build(:assignment_score) }

    specify { assignment_score.to_s.should eq assignment_score.score }
  end
end
