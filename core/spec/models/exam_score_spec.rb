require 'spec_helper'

describe Gaku::ExamScore do

  describe 'associations' do
    it { should belong_to :exam }
  end

  describe 'validations' do
  	let(:exam_score) { create(:exam_score) }

    it { should validate_presence_of :score }
    it { should validate_numericality_of :score }

    it 'errors when score is nil' do
      exam_score.score = nil
      exam_score.should_not be_valid
    end

    it 'should validate score is greater than 0' do
      exam_score.score = -1
      exam_score.should be_invalid
    end

    it 'should validate score is 0' do
      exam_score.score = 0
      exam_score.should be_valid
    end
  end

end
