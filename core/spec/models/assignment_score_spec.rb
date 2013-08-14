require 'spec_helper'

describe Gaku::AssignmentScore do

  describe 'relations' do
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :score }
    it { should validate_presence_of :student }
  end

  describe '#to_s' do
    let(:assignment_score) { build(:assignment_score) }
    specify { assignment_score.to_s.should eq assignment_score.score }
  end

end
