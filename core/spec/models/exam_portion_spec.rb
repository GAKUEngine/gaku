require 'spec_helper_models'

describe Gaku::ExamPortion, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :exam }
    it { is_expected.to belong_to :grading_method }

    it { is_expected.to have_many :exam_schedules }
    it { is_expected.to have_many :exam_portion_scores }
    it { is_expected.to have_many :attachments }
    it { is_expected.to have_many :attendances }
  end

  describe 'validations' do
    let(:exam_portion) { create(:exam_portion) }

    it { is_expected.to validate_presence_of :max_score }
    it { is_expected.to validate_numericality_of :max_score }

    it 'validates max_score is greater than 0' do
      exam_portion.max_score = -1
      exam_portion.should be_invalid
    end

    it 'validates max_score is 0' do
      exam_portion.max_score = 0
      exam_portion.should be_valid
    end

    it 'validates weight is greater than 0' do
      exam_portion.weight = -1
      exam_portion.should be_invalid
    end

    it 'validates weight is 0' do
      exam_portion.weight = 0
      exam_portion.should be_valid
    end
  end

  context 'methods' do
    xit 'student_score'
  end
end
