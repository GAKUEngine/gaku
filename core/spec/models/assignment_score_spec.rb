require 'spec_helper'

describe Gaku::AssignmentScore do

  describe 'associations' do
    it { should belong_to :student }
  end

  describe 'validations' do
    it 'is invalid without a score' do
      build(:assignment_score, score: nil).should_not be_valid
    end
  end

end
